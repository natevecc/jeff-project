express = require 'express'
path = require 'path'
router = express.Router()

# redirect all non api traffic to angular app
router.all '/*', (req, res, next) ->

  if req.user
    userCookie = JSON.stringify req.user.toJSON()
    res.cookie 'user', userCookie, 
      httpOnly: false
      signed: false

  res.sendFile path.resolve(__dirname + '/../../../client/index.html') # TODO make this configurable

module.exports = router