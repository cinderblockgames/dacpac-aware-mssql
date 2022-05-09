# dacpac-aware-mssql
MS SQL image that checks for dacpac updates every minute.

# Sample docker-compose

```
version: '3.8'

services:

  db:
    image: 'cinderblockgames/dacpac-aware-mssql:latest'
    environment:
      - 'DATABASE_NAME=YourDatabaseHere'
      - 'SA_PASSWORD=YourSecurePasswordHere'
    #env_file: .env
    volumes:
      - '/run/your-app/db:/var/opt/mssql'
      - '/run/your-app/dacpac:/tmp/db'
    networks: [your-app]
    deploy:
      mode: replicated
      replicas: 1
      placement:
        constraints: [node.platform.arch == x86_64]

networks:
  your-app:
    external: true
```
