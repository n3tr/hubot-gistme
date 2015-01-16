# Load assertion
nock = require 'nock'
chai = require 'chai'
sinon = require 'sinon'
path = require 'path'
chai.use require 'sinon-chai'
expect = chai.expect

Gist = require('../src/Gist.coffee').Gist


describe 'Gist', ->
	beforeEach ->

	it 'should can be access prop', ->
		gist = new Gist(null, null, null)
		expect(gist.name).to.equal("file1")

		gist1 = new Gist(null,"hello.js",null)
		expect(gist1.name).match(/hello.js/)


		expectedBody = {
			public: false,
			files: {
				hellojs: {
					content: "some-code"
				}
			}
		}

		gist2 = new Gist(null,"hellojs","some-code")
		expect(JSON.stringify(gist2.requestBody)).to.equal(JSON.stringify(expectedBody))

		expectedBody = {
			public: false,
			files: {
				file1: {
					content: "some-code"
				}
			}
		}

		gist2 = new Gist(null,null,"some-code")
		expect(JSON.stringify(gist2.requestBody)).to.equal(JSON.stringify(expectedBody))
		

	it 'should not valid if not provide access token', ->
		gist = new Gist(null, null, null)
		gist.create (error, url) ->
			expect(error).match(/access token/)

	describe 'requset', ->
		it 'should return url if success', ->
			gist = new Gist("some-token", "hello.js", "<someCode>")
			nock('https://api.github.com')
					.post('/gists?access_token=some-token')
					.reply 201, {html_url: "https://api.github.com/gists/46011db8b85e87963c2b" }

			
			gist.create (error , url) ->
				expect(url).match(/46011db8b85e87963c2b/)
		 
