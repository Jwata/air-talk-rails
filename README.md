# About this repository
This is a sample rails app for experimenting different PaaS/IaaS services.

## Heroku
Heroku is one of the platforms where you can deploy your rails app easily.

### Create app
```
heroku login
heroku key:add
heroku create air-talk-rails
```

### Deploy
```
heroku run rake db:migrate
git push heroku master
```
