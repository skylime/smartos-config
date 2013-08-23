# My SmartOS configuration (only for the global zone)

Location codes could be found on
http://www.unece.org/cefact/codesfortrade/codes_index.html

## Setup

Simple `scp` the content of one folder to `/opt/custom/`. For example:

    host=
    ssh root@${host} "mkdir /opt/custom/"
    scp -r de-muc-ipx/* ${host}:/opt/custom/
