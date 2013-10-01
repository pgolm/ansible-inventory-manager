# Ansible Inventory Manager

A Web UI to manage ansible inventories.

[DEMO](http://ansible-inventory-manager-demo.herokuapp.com/)

## Deploy on Heroku

```
heroku create <app-name>
heroku addons:add heroku-postgresql:dev 
git push heroku master 
heroku run rake db:setup
```

Login with:

```
User: admin@example.com
Password: admin
```

## Configuration

### Allow user registration
Set ```config.registrion = true``` in *config/application.rb*.