angular = require 'angular'
NavBar = require './navBarController'

module.exports = angular.module('jeff-app.navBar', [
  'templates'
  require('../authentication').name
  ])
.controller 'navBarController', NavBar