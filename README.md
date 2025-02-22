# Simple-HLS-listeners-Monitor

Simple python script to monitor HLS listeners connected to your HLS stream. Dockerized.

- Checks nginx log `/var/log/nginx/doamin-access.log` file every 20 seconds with `activity_window` of 40 seconds.
- If IP has been spotted within this time - it outputs data both to file `listeners.json` and sends data to your desired API.
- IP connection time is sumed up. When IP disconnects more than for 40 seconds - IP is forgotten.
- What it shows:
  - IP
  - User Agent
  - Duration of connection
  - Quality level IP is connected to.
  - Geo data is available via 2 API:
      1. findip.net (token needed) (`listeners.json`)
      2. ip-api.com (no token but limit is 40 IP per minute) (`listeners2.json`)
  - Geo data is cached for session.
- Shows data for any number of streams that are indicated in `STREAM_NAMES: "stream1,stream2"` env variable in `docker-compose.yml`
- Can be used without docker (look at dependencies inside Dockerfile)

## Important
For script to work the following structure for you HLS streams is needed as in `STREAM_NAMES: "stream1,stream2"` (Can be changed in regex in script itself):

https://your-domain.com/stream1/anyname.m3u8

https://your-domain.com/stream1/anyname.ts

https://your-domain.com/stream2/anyname.m3u8

https://your-domain.com/stream2/anyname.ts

## Example:

```json
{
    "total_listeners": {
        "stream1": 2,
        "stream2": 1
    },
    "stream1": [
        {
            "ip_address": "89.113.144.159",
            "user_agent": "AppleCoreMedia/1.0.0.19H386 (iPhone; U; CPU OS 15_8_3 like Mac OS X; ru_ru)",
            "duration": 700,
            "is_active": true,
            "quality_level": "aac_hifi",
            "geo": {
                "city": "Kurilovo",
                "continent": "Europe",
                "country": "Russia",
                "location": {
                    "latitude": 55.3727,
                    "longitude": 37.377,
                    "time_zone": "Europe/Moscow",
                    "weather_code": "RSXX1248"
                },
                "postal_code": null,
                "subdivisions": [
                    {
                        "geoname_id": 524925,
                        "name": "Moscow Oblast",
                        "iso_code": "MOS"
                    }
                ],
                "traits": {
                    "autonomous_system_number": 16345,
                    "autonomous_system_organization": "PJSC \"Vimpelcom\"",
                    "connection_type": "Cellular",
                    "isp": "SOVINTEL",
                    "organization": null,
                    "user_type": "cellular"
                }
            }
        },
        {
            "ip_address": "89.113.144.3",
            "user_agent": "AppleCoreMedia/1.0.0.19H386 (iPhone; U; CPU OS 15_8_3 like Mac OS X; ru_ru)",
            "duration": 700,
            "is_active": true,
            "quality_level": "aac_lofi",
            "geo": {
                "city": "Kurilovo",
                "continent": "Europe",
                "country": "Russia",
                "location": {
                    "latitude": 55.3727,
                    "longitude": 37.377,
                    "time_zone": "Europe/Moscow",
                    "weather_code": "RSXX1248"
                },
                "postal_code": null,
                "subdivisions": [
                    {
                        "geoname_id": 524925,
                        "name": "Moscow Oblast",
                        "iso_code": "MOS"
                    }
                ],
                "traits": {
                    "autonomous_system_number": 16345,
                    "autonomous_system_organization": "PJSC \"Vimpelcom\"",
                    "connection_type": "Cellular",
                    "isp": "SOVINTEL",
                    "organization": null,
                    "user_type": "cellular"
                }
            }
        }
    ],
    "stream2": [
        {
            "ip_address": "62.89.204.215",
            "user_agent": "Mozilla/5.0 (Linux; arm_64; Android 11; RMX2001) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/110.0.0.0 YaBrowser/23.3.6.40.00 SA/3 Mobile Safari/537.36",
            "duration": 700,
            "is_active": true,
            "quality_level": "aac_hifi",
            "geo": {
                "city": "Moscow",
                "continent": "Europe",
                "country": "Russia",
                "location": {
                    "latitude": 55.7558,
                    "longitude": 37.6173,
                    "time_zone": "Europe/Moscow",
                    "weather_code": "RSXX0063"
                },
                "postal_code": null,
                "subdivisions": [
                    {
                        "geoname_id": 524894,
                        "name": "Moscow",
                        "iso_code": "MOW"
                    },
                    {
                        "geoname_id": 524894,
                        "name": "Moscow",
                        "iso_code": "MOW"
                    }
                ],
                "traits": {
                    "autonomous_system_number": 211076,
                    "autonomous_system_organization": "PJSC NOVATEK",
                    "connection_type": "Corporate",
                    "isp": "Pjsc Novatek",
                    "organization": "Pjsc Novatek",
                    "user_type": "business"
                }
            }
        }
    ]
}
```
