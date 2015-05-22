models = require '../models'
express = require 'express'
router = express.Router()

errFn = (res)->
  (err) ->
    res.json err
      .status 500

router.post '/', (req, res) ->
  console.log "here"
  console.log req.body
  models.user.create(req.body)
  .then (newuser) ->
    res.json newuser
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
