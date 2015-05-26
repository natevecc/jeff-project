angular = require 'angular'
Login = require './loginController'
template = require './login.html'

module.exports = angular.module('jeff-app.login', ['templates'])
.controller 'loginController', Login