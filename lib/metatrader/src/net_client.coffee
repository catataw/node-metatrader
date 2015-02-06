InterfaceClient = require('./interface_client.js')

module.exports = class HttpsClient extends InterfaceClient

  constructor: (@executor) ->

  send: (command) ->
    command.processResponse(
      @executor.execute(
        command.generateRequiest()
    ))