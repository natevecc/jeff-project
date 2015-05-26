angular = require 'angular'
NavBar = require './navBarController'

module.exports = angular.module('jeff-app.navBar', [])
.controller 'navBarController', NavBar