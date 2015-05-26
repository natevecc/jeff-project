express = require 'express'
path = require 'path'
router = express.Router()

router.all '/*', (req, res, next) ->
  res.sendFile path.resolve(__dirname + '/../../../client/index.html') # TODO make this configurable

module.exports = router