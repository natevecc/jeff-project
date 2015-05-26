express = require 'express'
path = require 'path'
router = express.Router()

# redirect all non api traffic to angular app
router.all '/*', (req, res, next) ->
  console.log req
  res.sendFile path.resolve(__dirname + '/../../../client/index.html') # TODO make this configurable

module.exports = router