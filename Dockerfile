# https://www.wintellect.com/automating-sql-server-2019-docker-deployments/
FROM mcr.microsoft.com/mssql/server:2019-latest

# Elevate to root
USER root

# Install necessary packages
RUN echo "deb http://security.ubuntu.com/ubuntu xenial-security main" >> /etc/apt/sources.list && \
    apt-get update && \
    apt-get install unzip libunwind8 libicu66 libssl1.0 -y
    
# Add dacpac management
COPY *.sh /run/db/

# Install SQLPackage for Linux and make it (and dacpac management) executable
RUN wget -progress=bar:force -q -O sqlpackage.zip https://go.microsoft.com/fwlink/?linkid=2113331 && \
    unzip -qq sqlpackage.zip -d /opt/sqlpackage && \
    chmod +x /opt/sqlpackage/sqlpackage && \
    chmod +x /run/db/*.sh

# Configure the required environmental variables
ENV ACCEPT_EULA=Y
ENV MSSQL_PID=Express
ENV DATABASE_NAME=YourDatabaseHere
#ENV SA_PASSWORD

# This is where dacpacs and logs go.
VOLUME /tmp/db

# Make sure cron is running and has the dacpac management set up.
CMD /run/db/start.sh
