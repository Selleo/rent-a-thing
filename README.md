# README
#zmiana
## Setting up application locally

- Ensure you have docker installed
- Ensure you are using the correct ruby version (look into `.ruby_version` for reference)

In project directory

- `rvm use 3.0.1@rent-a-thing --create` sets the right gemset (if using `rvm`)
- `docker-compose up` - runs PostgreSQL and Redis
- `cp config/database.yml.example config/database.yml` - instantiates local database configuration
- `cp .env.example .env` - instantiates local ENV variables
- `bundle install` - installs all necessary gems (libraries)
- `rails db:create db:schema:load` - creates DB and loads the most recent DB structure
- `rails db:seed` - to seed database with initial data (admin account and some test data basically)
- `yarn install` - install YARN
- `rails s` - runs application server

- open [localhost:3000](http://localhost:3000/) and use following credentials to login
    - email: `admin@example.com`
    - pass: `password`

To run [sidekiq](https://github.com/mperham/sidekiq) (asynchronous processing) locally

- `bundle exec sidekiq -C config/sidekiq.yml`

... however for most development purposes you will not need to run this. There are a couple of asynchronous tasks ran frequently that might affect our systems (see `config/schedule.yml`). 
You can run those directly from rails console on demand.
