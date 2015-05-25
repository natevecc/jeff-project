models = require '../models'
Promise = require 'bluebird'
bcrypt = Promise.promisifyAll require('bcrypt')
express = require 'express'
router = express.Router()

errFn = (res)->
  (err) ->
    console.log err
    res
    .status 500
    .json err

router.post '/', (req, res) ->
  newUser = req.body
  bcrypt.genSaltAsync(10)
  .then (salt) ->
    bcrypt.hashAsync(newUser.password, salt)
  .then (password) ->
    newUser.password = password
    models.user.create(newUser)
  .then (createdUser) ->
    res
    .status 201
    .json createdUser
    for key of createdUser.dataValues
      console.log key
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
