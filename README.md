# README

## Development

First create a local envirnment file n the project directory call `.envrc`. It should look similar to this

    export DB_PORT=5432
    export POSTGRES_USER=culture
    export POSTGRES_PASSWORD=
    export DEVISE_SECRET=
    export SECRET_KEY_BASE=
    export SMTP_PORT=10025
    export SMTP_SERVER=127.0.0.1

Set your DB password and long random strings for the DEVISE_SECRET and SECRET_KEY_BASE.

NOTE: there is a mailcatcher instance in the docker compose so any emails sent by the app can be read via `http://localhost:1080/`

Using docker compose:

Create volumes for the Postfres data and the node modules using the **docker volume create** command:

docker volume create --name=culture-pgdata
docker volume create --name=culture-node-modules

You can then build and start the docker containers using

    docker-compose -p culture-dev -f docker-compose-dev.yml up --build

Or

    docker-compose -p culture-dev -f docker-compose-dev.yml up --build -d

The Rails container will use the local directory and is running vite in dev mode for HMR. You can access the application
using `http://localhost:5100`
