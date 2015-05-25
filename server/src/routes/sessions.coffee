models = require '../models'
auth = require '../services/authentication'
Promise = require 'bluebird'
express = require 'express'
router = express.Router()

router.post '/'
, (req, res, next) ->
  fn = auth.authenticate 'local' 
  , (err, user, info) ->
    console.log 1
    if err
      return next err
    console.log 2
    if not user
      return res
      .status 404
      .json
        error: info.message
    req.login user, (err) ->
      if err
        return next err
      res
      .status 200
      .end()
  fn(req, res, next)

router.delete '/', (req, res) ->
  req.logout()

module.exports = router