#!/bin/sh

database=${DATABASE_NAME}
dacpac=/tmp/db/$database.dacpac
password=${SA_PASSWORD}
log=/tmp/db/dacpac.log

if [ -f $dacpac ]; then
  mv $dacpac $dacpac.running.dacpac
  dacpac=$dacpac.running.dacpac

  if [ -f $log ]; then
    rm $log
  fi

  /opt/sqlpackage/sqlpackage /a:Publish /p:DropObjectsNotInSource=True /tsn:. /tdn:$database /tu:sa /tp:$password /sf:$dacpac >$log 2>&1
  wait $!
  rm $dacpac
fi
