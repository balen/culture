# README

## Development

First create a local environment file in the project directory call `.envrc`. It should look similar to this

    export DB_PORT=5432
    export POSTGRES_USER=culture
    export POSTGRES_PASSWORD=
    export DEVISE_SECRET=
    export SECRET_KEY_BASE=
    export SMTP_PORT=10025
    export SMTP_SERVER=127.0.0.1
    export VITE_SUPPORTED_LOCALES=en,fr,pt_BR
    export VITE_DEFAULT_LOCALE=fr
    export VITE_FALLBACK_LOCALE=en
    export CYPRESS_RAILS_PORT=5100

Set your DB password and long random strings for the DEVISE_SECRET and SECRET_KEY_BASE.

NOTE: there is a mailcatcher instance in the docker compose so any emails sent by the app can be read via `http://localhost:1080/`

## Using Docker Compose

Create volumes for the Postgres data and the node modules using the **docker volume create** command:

    docker volume create --name=culture-pgdata
    docker volume create --name=culture-node-modules

You can then build and start the docker containers using

    docker-compose -p culture-dev -f docker-compose-dev.yml up --build

Or

    docker-compose -p culture-dev -f docker-compose-dev.yml up --build -d

The Rails container will use the local directory and is running vite in dev mode for HMR. You can access the application
using `http://localhost:5100`

## Native Rails

`source .envrc`

### Setup

1. (psql) `create user culture with password '********' createdb;`
2. `RAILS_ENV=test bundle exec rake db:create`
3. `RAILS_ENV=test bundle exec rake db:schema:load`
4. `RAILS_ENV=test bundle exec rake survey:init_or_update` # load survey data
5. `RAILS_ENV=test bundle exec rake views:recreate` # (re)create the views
6. `RAILS_ENV=test bundle exec rake db:seed` # create seeed data

### Testing

`bin/tests` # setup and run the spec tests

To run the cypress tests, first make sure that CYPRESS_RAILS_PORT has been set to 5100 (see above)

`rake cypress:open`

The test scripts are in cypress/e2e

### Dev

`bin/rails s`

Open your browser to `http://localhost:3000/en/admin` and login as test@test.com, password 111111
