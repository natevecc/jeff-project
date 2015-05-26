
module.exports = class Login
  @$inject = [
    '$http'
    '$rootScope'
    '$state'
    'authentication'
  ]
  constructor: (@$http, @$rootScope, @$state, @authentication) ->
    @alert =
      type: "danger"
      msg: ""
      show: false

  login: (email, password) ->
    @authentication.login(email, password)
    .catch (err) =>
      # show login error popup
      @alert.msg = "Error during login: #{err.data.error}"
      @alert.show = true
      @$rootScope.user = null

  register: (email, password) ->
    @authentication.register(email, password)
    .catch (err) =>
      # show login error popup
      @alert.msg = "Error during registration: #{res.data.error}"
      @alert.show = true
