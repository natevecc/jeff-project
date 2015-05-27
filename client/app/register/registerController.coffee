
module.exports = class Register
  @$inject = [
    '$state'
    'authentication'
  ]
  constructor: (@$state, @authentication) ->
    @alert =
      type: "danger"
      msg: ""
      show: false

    @validRoles = [
      'viewer'
      'admin'
    ]

  register: (options) ->
    @authentication.register(options)
    .catch (err) =>
      # show login error popup
      @alert.msg = "Error during registration: #{err.data.error}"
      @alert.show = true
