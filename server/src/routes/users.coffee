models = require '../models'
Promise = require 'bluebird'
bcrypt = Promise.promisifyAll require('bcrypt')
express = require 'express'
router = express.Router()
auth = require('../services/authentication')

errFn = (res)->
  (err) ->
    res
    .status 500
    .json 
      err: err
      stack: err.stack

router.use (req, res, next) ->
  if req.method is "POST"
    return next()
  auth.authMiddleware(req, res, next)

router.post '/', (req, res) ->
  newUser = req.body
  bcrypt.genSaltAsync(10)
  .then (salt) ->
    bcrypt.hashAsync(newUser.password, salt)
  .then (password) ->
    newUser.password = password
    models.user.create(newUser)
  .then (createdUser) ->
    req.login createdUser, (err) ->
      if err 
        return next(err)
      res
      .status 201
      .json createdUser
  .catch errFn(res)

router.get '/', (req, res) ->
  if req.user.role isnt 'admin'
    return res
      .status 401
      .json
        error: "Insufficient Permissions"
  models.user.findAll()
  .then (users) ->
    res.json users
  , errFn res

router.get '/:id', (req, res) ->
  if req.user.role isnt 'admin' or 
      req.user.id isnt req.params.id
    return res
      .status 401
      .json
        error: "Insufficient Permissions"
  models.user.findById(req.params.id)
  .then (user) ->
    if user?
      res.json user
    else
      res.status 404
      .end()
  , errFn res

router.delete '/:id', (req, res) ->
  if req.user.role isnt 'admin' 
    return res
      .status 401
      .json
        error: "Insufficient Permissions"
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
