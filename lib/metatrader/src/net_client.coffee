InterfaceClient = require('./interface_client.js')

module.exports = class HttpsClient extends InterfaceClient

  constructor: (@executor) ->

  send: (command, callback, error) ->
    request = command.generateRequest()
    @executor.execute request, command.stopReadCallback, (response) =>
      callback(command.processResponse(response))
    , error