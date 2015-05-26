angular = require 'angular'
Home = require './homeController'
template = require './home.html'

module.exports = angular.module('jeff-app.home', ['templates'])
.controller 'homeController', Home