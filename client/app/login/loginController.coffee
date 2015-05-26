
module.exports = class Login
  @$inject = [
    '$http'
    '$rootScope'
    '$state'
  ]
  constructor: (@$http, @$rootScope, @$state) ->
    @alert =
      type: "danger"
      msg: ""
      show: false

  login: (username, password) ->
    @$http.post('/api/sessions', {email: username, password: password})
    .then (res) =>
      # success and redirect to root
      @$rootScope.loggedIn = true
      @$state.go('home')
    .catch (err) =>
      # show login error popup
      @alert.msg = "Error during login"
      @alert.show = true
      @$rootScope.loggedIn = false

  register: (username, password) ->
    @$http.post('/api/users', {email: username, password: password})
    .then (res) =>
      # success and redirect to root
      @$rootScope.loggedIn = true
    .catch (err) =>
      # show login error popup
      @alert.msg = "Error during register"
      @alert.show = true
      @$rootScope.loggedIn = false
