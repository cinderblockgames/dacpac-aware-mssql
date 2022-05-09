#!/bin/sh

# Check for dacpac once a minute (in the background).
while true; do sleep 60; /bin/sh /run/db/dacpac.sh; done &

# Run SQL Server in the foreground.
/bin/sh /opt/mssql/bin/sqlservr
