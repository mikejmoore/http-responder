# HTTP Responder

This is a simpleRails application for loading down a host system for each request.

Every request can specify optional parameters to force the host system to use varying levels of CPU, Memory and File IO.

## Possible Uses:
* Testing connectivity.
* Testing load balancing.
* Testing AWS Autoscaling.

## To Run:
```
> RAILS_ENV=production rails s -p <port-number>
```

## Example requests (using cURL)
Responds with JSON containing the parameters used by the handling code:
```
> curl "localhost:3000?memory=1000&cpu=100&delay=1000&file=100"

{"host":"host-10-19-79-12","delay":1000,"cpu":100,"memory":1000,"timestamp":"2017-12-30 14:29:01 -0700","uuid":"5d893ce4-e582-4810-a29a-5ade921dc788"}
```
## Parameters
* delay - Value of 0 - large-number to indicate the delay in responding to the request. The unit is milliseconds.
* cpu - Value of 1-100 to indicate the intensity of CPU usage for the handler.
* file - Value of 0 - large-number to indicate how much file IO to perform per request.  Too large of a number will delay the request more than the 'delay' parameter specifies.
* memory - Value of 0 - large-number to indicate how many GB's of memory to use while handling the request.
