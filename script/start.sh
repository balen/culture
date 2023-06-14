#!/usr/bin/env sh
#
export NODE_ENV=${RAILS_ENV}

# Development environment setup runs when RAILS_ENV is not set
if [[ -z $RAILS_ENV ]] || [[ $RAILS_ENV = "development" ]]; then
  gem install bundler:2.3.26
  bin/bundle install --quiet

  # Do not let Yarn change versions of modules (causes problems of we do)
  bin/vite install

  # Create DB if it is not already there
  bin/rake db:db_missing || (bin/rails db:create; bin/rails db:schema:load)

  # bin/rake views:recreate
  bin/rake db:migrate

  # Run migrations and start the server, anything that comes in on 3000 is accepted
  # bin/rails db:create
  bin/rails db:seed
elif [[ $RAILS_ENV = "staging" ]]; then
  export RAILS_SERVE_STATIC_FILES=true
  bin/rake db:db_missing || (bin/rails db:create; bin/rails db:schema:load)

  # bin/rake views:recreate
  bin/rake db:migrate
  bin/rails db:seed

  bin/rake assets:precompile
else
  export RAILS_SERVE_STATIC_FILES=true
  until psql -Atx "postgresql://$POSTGRES_USER:$POSTGRES_PASSWORD@$DB_HOST" -c 'select current_date'; do
    echo "waiting for postgres..."
    sleep 5
  done
  bin/rake db:db_missing || (bin/rails db:create; bin/rails db:schema:load)

  # bin/rake views:recreate
  bin/rake db:migrate

  bin/rake assets:precompile
fi

# TODO: check as dev server is bin/dev
if [[ -z $RAILS_ENV ]] || [[ $RAILS_ENV = "development" ]]; then
  bin/dev
else
  bin/rails server -b 0.0.0.0
fi
