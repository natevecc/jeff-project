angular = require 'angular'

module.export = angular.module("jeff-app", [])
  .controller "test", () ->
    @name = "tester"
    @value = "theValue"