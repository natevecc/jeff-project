express = require 'express'
path = require 'path'
bodyParser = require 'body-parser'
logger = require 'morgan'
espressSession = require 'express-session'
#cookieParser = require 'cookie-parser'

# load routers
routes = require './routes/index'
users = require './routes/users'
sessions = require './routes/sessions'

# load services
auth = require './services/authentication'

server = express()

# set up 
server.set 'views', __dirname + '/views'
server.engine 'html', require('ejs').renderFile
server.set 'view engine', 'html'

server.use logger('dev')
server.use(bodyParser.json
  type: 'application/json'
)
#server.use cookieParser()
server.use express.static(path.resolve(__dirname + '/../../client'))

server.use espressSession(
  secret: 'superSecretSSSHHHH' # TODO: make configurable
  resave: false
  saveUninitialized: false
)
server.use auth.initialize()
server.use auth.session()

server.use('/', routes)
server.use('/api/users', users)
server.use('/sessions', sessions)

module.exports = server
