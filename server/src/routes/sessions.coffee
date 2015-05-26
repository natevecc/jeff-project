models = require '../models'
auth = require '../services/authentication'
Promise = require 'bluebird'
express = require 'express'
router = express.Router()

router.post '/'
, (req, res, next) ->
  fn = auth.authenticate 'local' 
  , (err, user, info) ->
    if err
      return next err
    if not user
      return res
      .status 400
      .json
        error: info.message
    req.login user, (err) ->
      if err
        return next err
      res.json user
  fn(req, res, next)

router.delete '/', (req, res) ->
  req.logout()
  res
  .status 204
  .end()

module.exports = router