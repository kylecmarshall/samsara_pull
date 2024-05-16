import sys
import json
from pathlib import Path
import requests

def main(args):
    # print('[ARGS start]')
    # print(args)
    # print('[ARGS finish]')
    
    url = args["--host-url"] + args["<path>"]

    headers = {
        "accept": "application/json",
        "authorization": f"Bearer {args['--api-token']}"
    }

    # receives json object per line
    for line in sys.stdin:
        line = line.rstrip()
        params = json.loads(line)
        do_request(url, headers, params)
           

def do_request(url, headers, params):
    has_next_page = True
    while has_next_page:
        response = requests.get(url, params=params, headers=headers)
        assert response.status_code == 200
        response = response.json()
        json.dump(response['data'], sys.stdout)
        print()
        sys.stdout.flush()
        if response["pagination"]["hasNextPage"]:
            params["after"] = response["pagination"]["endCursor"]
            has_next_page = True
        else:
            has_next_page = False

def check_api_token(args):
    if args['--api-token'] is None:
        # Check in ~/.samsara/config.json for api token
        with open(Path.home() /'.samsara'/'config.json','r') as f:
            config = json.load(f)
            args['--api-token'] = config['api_token']

_doc = """Retrieve from Samsara.

Usage:
  samsara_pull.py [options] <path>

Options:
  -h --help         Show this screen.
  --host-url=HOST   Samsara API Host URL [default: https://api.samsara.com].
  --api-token=TOKEN Samsara API Token

"""
from docopt import docopt

def main_cli():
    args = docopt(_doc)
    check_api_token(args)
    main(args)
    sys.stdout.flush()
    sys.stdout.close()

if __name__ == '__main__':
    main_cli()