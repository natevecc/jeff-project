app = require '../app'
template require './login.html'

class Login
  constructor: (@$http) ->

  login: (username, password) ->
    $http.post('/api/sessions', {username: username, password: password})
    .then (res) ->
      # success and redirect to root
    .catch (err) ->
      # show login error popup

app.controller 'login', [
  '$http' 
  Login
]