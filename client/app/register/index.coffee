angular = require 'angular'
Register = require './registerController'
template = require './register.html'

module.exports = angular.module('jeff-app.register', [
  'templates'
  require('../authentication').name
])
.controller 'registerController', Register