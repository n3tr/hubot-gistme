# Hubot classes
Helper = require('hubot-test-helper')

# Load assertion
nock = require 'nock'
chai = require 'chai'
sinon = require 'sinon'
path = require 'path'
chai.use require 'sinon-chai'
expect = chai.expect

process.env.GIST_ACCESS_TOKEN = "ee33"

helper = new Helper('../src/gist-me.coffee')

describe 'gistme', ->
  beforeEach ->
    @robot =
      respond: sinon.spy()
      hear: sinon.spy()

    require('../src/gist-me.coffee')(@robot)

  it 'registers a respond listener', ->
    expect(@robot.respond).to.have.been.calledWith(/gistme (\S*\.\S+)?((.*\s*)+)/i)
  it 'registers a respond listener', ->
    expect(@robot.respond).to.have.been.calledWith(/gist-token:reset/i)
  it 'registers a respond listener', ->
    expect(@robot.respond).to.have.been.calledWith(/gist-token:set (.*)/i)




describe 'gistme create gist', ->
  room = null

  beforeEach (done) ->
    room = helper.createRoom()
    done()

  afterEach ->

  it "responsd when provide TOKEN, short text",  ->
    
    room.user.say 'alice', 'hubot gistme 33ee'
    expect(room.messages).to.eql [
      ['alice', 'hubot gistme 33ee']
      ['hubot', 'Code is too short, Please try again.']
    ]


