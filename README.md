# About this repository
This is a sample rails app for experimenting different PaaS/IaaS services.

## Setup
Before deployment, you need to setup a secret key for production
In this demo, you will use [Encrypted secrets](https://github.com/rails/rails/blob/db844d9fb30cd34411fcdcc6780f82aaa5471e81/guides/source/5_1_release_notes.md#encrypted-secrets) to manage the secret key. you will also need to set a environment variable `RAILS_MASTER_KEY` on each platform.

```
> rails secrets:setup
> cat config/secrets.yml.key
=> your_rails_master_key
```
```
> rails secrets:edit
# production:
#   secret_key_base: your_secret_key
```

## Heroku
Heroku is one of the platforms where you can deploy your rails app easily.

### Create app
```
heroku login
heroku key:add
heroku create air-talk-rails
heroku config:set RAILS_MASTER_KEY=`cat config/secrets.yml.key`
```

### Deploy
```
heroku run rake db:migrate
git push heroku master
```
