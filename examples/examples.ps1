@{ filterBy = "vehicles"; startTime = "2024-01-04T00:00:00Z"; endTime = "2024-01-05T00:00:00Z"},
@{ filterBy = "vehicles"; startTime = "2024-01-05T00:00:00Z"; endTime = "2024-01-06T00:00:00Z"},
@{ filterBy = "vehicles"; startTime = "2024-01-06T00:00:00Z"; endTime = "2024-01-07T00:00:00Z"},
@{ filterBy = "vehicles"; startTime = "2024-01-07T00:00:00Z"; endTime = "2024-01-08T00:00:00Z"},
@{ filterBy = "vehicles"; startTime = "2024-01-08T00:00:00Z"; endTime = "2024-01-09T00:00:00Z"},
@{ filterBy = "vehicles"; startTime = "2024-01-09T00:00:00Z"; endTime = "2024-01-10T00:00:00Z"}, 
@{ filterBy = "vehicles"; startTime = "2024-01-10T00:00:00Z"; endTime = "2024-01-11T00:00:00Z"} | foreach {$_ | ConvertTo-Json -Compress} | 
    samsara-pull /fleet/driver-vehicle-assignments | ConvertFrom-Json
    ConvertTo-Json -Compress > driver_vehicles.jol

@{ limit = "512" } | ConvertTo-Json -Compress | samsara-pull /fleet/drivers | ConvertFrom-Json

@{ limit = "512" } | ConvertTo-Json -Compress | samsara-pull /fleet/vehicles | ConvertFrom-Json


@{ filterBy = "vehicles"; startTime = "2024-01-10T00:00:00Z"; endTime = "2024-01-11T00:00:00Z"} | foreach {$_ | ConvertTo-Json -Compress} | 
    samsara-pull /fleet/driver-vehicle-assignments | ConvertFrom-Json |
    foreach {$_ | ConvertTo-Json -Compress } | Out-File driver_vehicles.jol


@{ filterBy = "vehicles"; startTime = "2024-01-11T00:00:00Z"; endTime = "2024-01-12T00:00:00Z"} | foreach {$_ | ConvertTo-Json -Compress} | 
    samsara-pull /fleet/driver-vehicle-assignments | ConvertFrom-Json

@{ startTime = "2024-01-12T00:00:00Z"; endTime = "2024-01-13T00:00:00Z"; types = "gpsDistanceMeters"; decorations= "obdOdometerMeters" } | 
    ConvertTo-Json -Compress | samsara-pull /fleet/vehicles/stats/history | ConvertFrom-Json 

@{ types = "gpsDistanceMeters"; } |
ConvertTo-Json -Compress | samsara-pull /fleet/vehicles/stats | ConvertFrom-Json |

@{ limit = "512" } | ConvertTo-Json -Compress | samsara-pull /fleet/drivers | ConvertFrom-Json
@{ limit = "512" } | ConvertTo-Json -Compress | samsara-pull /fleet/vehicles | ConvertFrom-Json