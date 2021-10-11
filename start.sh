#!/bin/sh

# Check for dacpac once a minute (in the background).
while true; do sleep 60; /run/db/dacpac.sh; done &

# Run SQL Server in the foreground.
/opt/mssql/bin/sqlservr
