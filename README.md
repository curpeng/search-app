# README

## Requirements
  Ruby 2.6.3

## Run this locally

This project uses a .env file to read twitter credentials. Make a copy of
the `.env.sample` file and update the environment variables to correspond with
your setup.

```bash
$ cp .env.sample .env
```

After that run:

```bash
bundle install
bundle exec rake db:create db:migrate
bundle exec rails s
```

Now you are ready to run a search query:

```
curl -v http://localhost:3000/messages/search?term=brexit
```
