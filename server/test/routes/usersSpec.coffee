request = require 'supertest-as-promised'
expect = require('chai').expect
server = require '../../src/server'
models = require '../../src/models'

describe 'api/users', ->

  afterEach ->
    models.user.destroy
      truncate: true
      force: true

  agent = request(server)

  describe 'POST /', ->
    it "creates a user and hashes it's password", () ->
      agent
      .post('/api/users')
      .send
        email: 'create1@test.com'
        password: 'testPassword1234'
      .expect(201)
      .then (req) ->
        createdUser = req.body
        expect(createdUser).to.have.property('email', 'create1@test.com')
        expect(createdUser).to.not.have.property('password')
        models.user.findById(createdUser.id)
      .then (createdUserDB) ->
        expect(createdUserDB).to.have.property('password').with.length(60)

  describe 'GET /', ->

    users = [
      email: 'test1@test.com'
      password: 'hash1'
    ]

    beforeEach ->
      models.user.bulkCreate users

    # TODO move all of this to a test helper of some sort
    authedAgent = request.agent(server)
    before ->
      agent
      .post('/api/users')
      .send
        email: 'authuser@test.com'
        password: 'password1234'
      .then (res) ->
        authedAgent
        .post('/sessions')
        .send
          email: 'authuser@test.com'
          password: 'password1234'
      .catch (err) ->
        console.log err

    it 'returns a list of users in the db', ->
      authedAgent
      .get('/api/users')
      .expect(200)
      .then (req) ->
        expect(req.body).to.have.length(2)
