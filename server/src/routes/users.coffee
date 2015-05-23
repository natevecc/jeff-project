models = require '../models'
Promise = require 'bluebird'
bcrypt = Promise.promisifyAll require('bcrypt')
express = require 'express'
router = express.Router()

errFn = (res)->
  (err) ->
    res.json err
      .status 500

router.post '/', (req, res) ->
  newUser = req.body
  bcrypt.genSalt(10)
  .then (salt) ->
    bcrypt.hashAsync(newUser.password, salt, null)
  .then (password) ->
    newUser.password = password
    models.user.create(newUser)
  .then (createdUser) ->
    res.json createdUser
  , errFn res

router.get '/', (req, res) ->
  models.user.findAll()
  .then (users) ->
    res.json users
  , errFn res

router.get '/:id', (req, res) ->
  models.user.findById(req.params.id)
  .then (user) ->
    if user?
      res.json user
    else
      res.status 404
      .end()
  , errFn res

router.delete '/:id', (req, res) ->
  models.user.findById(req.params.id)
  .then (user) ->
    user.destroy() .then ->
      res.status 204
      .end()
    , errFn res
    return
  , (err) ->
    res.status 404
    .end()

module.exports = router
