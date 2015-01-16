Octonode = require 'octonode'

class Gist
	constructor: (@token,@name,@code) ->
		@name ||= "file1"
		@code ||= ""

		content = {}
		content["content"] = @code
		
		files = {}
		files[@name] = content

		@requestBody = {}
		@requestBody["public"] = false
		@requestBody["files"] = files

	create: (cb) ->
		return cb 'Gist access token not found' unless @token 

		client = Octonode.client(@token)
		ghgist = client.gist()

		ghgist.create @requestBody, (error, body, header) ->
			return cb "Error to create gist" if error

			unless body
				return cb "Cannot create gist"

			url = body.html_url
			return cb null , "#{url}"

module.exports.Gist = Gist
		
