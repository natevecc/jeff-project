angular = require 'angular'

angular.module("jeff-app", [])
  .controller "test", () ->
    @name = "tester"
    @value = "theValue"