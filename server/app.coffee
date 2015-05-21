express = require 'express'
path = require 'path'

app = module.exports = express()

app.use express.static(path.resolve(__dirname + '/../client'))
app.set 'views', __dirname + '/views'
app.engine 'html', require('ejs').renderFile
app.set 'view engine', 'html'

app.route('/').get (req, res) ->
  res.sendFile path.resolve(__dirname + '/../client/index.html') # TODO make this configurable
  return

server = app.listen(3000, ->
  host = server.address().address
  port = server.address().port
  console.log 'jeff-project listening at http://%s:%s', host, port
  return
)