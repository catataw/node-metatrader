InterfaceClient = require('./interface_client.js')

module.exports = class HttpsClient extends InterfaceClient

  constructor: (@executor) ->

  send: (command, callback) ->
    request = command.generateRequest()
    @executor.execute request, (response) =>
      callback(command.processResponse(response))