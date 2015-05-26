angular = require 'angular'
uiRouter = require 'angular-ui-router'
routes = require './routes'
login = require './login'
home = require './home'
navBar = require './navBar'
register = require './register'


module.exports = angular.module("jeff-app", [
  'templates'
  uiRouter
  home.name
  login.name
  navBar.name
  register.name
])
.config(routes)