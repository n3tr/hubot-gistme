# Description:
#   Allow you to Create Gist via Hubot
#
# Dependencies:
#   "octonode"
#
# Configuration:
#   GIST_ACCESS_TOKEN - (optional) Github access token with 'gist' scope.
#
# Commands:
#   hubot gistme <code> - Create Gist
#   hubot gistme <filename> <code> - Create Gist with filename (eg. hello.js)
#		hubot gist-token:set <github_access_token> - set access token for the user, token with 'gist' scope.
#		hubot gist-token:reset - remove access token of the user.
#
# Author:
#   Jirat Ki. (n3tr)

github = require 'octonode'
path = require 'path'
TokenVerifier  = require(path.join(__dirname, "token_verifier")).TokenVerifier
Gist = require(path.join(__dirname, "Gist.coffee")).Gist

DEFAULT_ACCESS_TOKEN = process.env.GIST_ACCESS_TOKEN

module.exports = (robot) ->
	robot.respond /gistme (\S*\.\S+)?((.*\s*)+)/i, (msg) ->
		
		name = msg.match[1]
		code = msg.match[2]

		if !code
			return msg.send "Code is missing.";

		if code.length < 5
			return msg.send "Code is too short, Please try again."

		user = robot.brain.userForId msg.envelope.user.id
		
		if user? and user.gistToken?
			token = user.gistToken 
		token ||= DEFAULT_ACCESS_TOKEN
		
		unless token?
			msg.reply "Please set GIST_ACCESS_TOKEN or set you own token by `hubot gist-token:set <you_token>`"
			return

		name ||= 'file1'

		gist = new Gist(token,name,code)
		gist.create (error, url) ->
			if error
				return msg.send error
			msg.send "Gist created #{name}: #{url}"

#######################################################
################# TOKEN SET - RESET ###################
#######################################################
	
	robot.respond /gist-token:set (.*)/i, (msg) ->
		token = msg.match[1]

		verifier = new TokenVerifier(token)
		verifier.valid (result) ->
			if result
				msg.reply "Your token is valid. I stored it for future use."
				user = robot.brain.userForId msg.envelope.user.id
				user.gistToken = verifier.token
			else
				msg.reply "Your token is invalid, verify that it has 'gist' scope."

	robot.respond /gist-token:reset/i, (msg) ->
		user = robot.brain.userForId msg.envelope.user.id
		delete(user.gistToken)
		msg.reply "Your token has been removed."

