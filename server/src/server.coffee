express = require 'express'
path = require 'path'
bodyParser = require 'body-parser'
logger = require 'morgan'

# loud routers
routes = require './routes/index'
users = require './routes/users'

app = express()

# set up 
app.set 'views', __dirname + '/views'
app.engine 'html', require('ejs').renderFile
app.set 'view engine', 'html'

app.use logger('dev')
app.use(bodyParser.json
  type: 'application/json'
)
app.use express.static(path.resolve(__dirname + '/../client'))

app.use('/', routes)
app.use('/api/users', users)

module.exports = app
