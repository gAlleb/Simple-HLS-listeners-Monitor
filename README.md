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
- Shows data for any number os streams that are indicated in `STREAM_NAMES: "stream1,stream2"` env variiable in `docker-compose.yml`
- Can be used without docker (look at dependencies inside Dockerfile)

## Important.
For script to work the following structure for you HLS streams is needed (Can be changed in regex in script itself):

https://your-domain.com/STREAM_NAME_1/anyname.m3u8

https://your-domain.com/STREAM_NAME_1/anyname.ts

https://your-domain.com/STREAM_NAME_2/anyname.m3u8

https://your-domain.com/STREAM_NAME_2/anyname.ts
