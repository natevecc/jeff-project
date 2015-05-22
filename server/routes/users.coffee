models = require '../models'
express = require 'express'
router = express.Router()

errFn = (res)->
  (err) ->
    res.json err
      .status 500
    return

router.post '/', (req, res) ->
  models.User.create(req.body)
  .then (newUser) ->
    res.json newUser
    return
  , errFn res
  return

router.get '/', (req, res) ->
  models.User.findAll()
  .then (users) ->
    res.json users
    return
  , errFn res
  return

router.get '/:id', (req, res) ->
  models.User.find(
    where: 
      id: req.params.id
  )
  .then (user) ->
    if user?
      res.json user
    else
      res.status 404  
    return
  , errFn res
  return

router.delete '/:id', (req, res) ->
  models.User.find(
    where: 
      id: req.params.id
  )
  .then (user) ->
    if user?
      user.destroy() .then ->
        res.status 204
        return
      , errFn res
    else
      res.status 404
    return
  return

module.exports = router
