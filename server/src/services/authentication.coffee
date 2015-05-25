models = require '../models'
Promise = require 'bluebird'
bcrypt = Promise.promisifyAll require('bcrypt')
passport = require 'passport'
LocalStrategy = require('passport-local').Strategy

passport.serializeUser (user, done) ->
  done null, user.get('id')

passport.deserializeUser (id, done) ->
  models.user.findById(id)
  .then (user) ->
    done null, user
  , (err) ->
    done err, null

passport.use new LocalStrategy(
    usernameField: 'email'
    passwordField: 'password'
  ,
  (username, password, done) ->
    models.user.findOne(
      where: 
        email: username)
    .bind({})
    .then (user) ->
      this.user = user
      bcrypt.compareAsync(password, user.get('password'))
    .then (passwordsMatch) ->
      if not this.user
        return done null, false, message: 'Unknown user'
      else if not passwordsMatch
        done null, false, message: 'Invalid password'
      else
        done null, this.user
    .catch (err) ->
      
      done err
)

# helper function to be used in routes to authenticate resources
passport.authMiddleware = (req, res, next) ->
  if req.isAuthenticated()
    return next()
  res
  .status 401
  .end()

module.exports = passport
