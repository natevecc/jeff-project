angular = require 'angular'
uiRouter = require 'angular-ui-router'
angularBootstrap = require 'angular-bootstrap-npm'
routes = require './routes'
login = require './login'
home = require './home'
navBar = require './navBar'


module.exports = angular.module("jeff-app", [
  'templates'
  uiRouter
  angularBootstrap
  home.name
  login.name
  navBar.name
])
.config(routes)