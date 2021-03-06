
module.exports = class Login
  @$inject = [
    '$state'
    'authentication'
  ]
  constructor: (@$state, @authentication) ->
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
