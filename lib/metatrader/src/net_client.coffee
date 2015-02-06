InterfaceClient = require('./interface_client.js')

module.exports = class HttpsClient extends InterfaceClient

  constructor: (@executor) ->

  send: (command, callback) ->
    request = command.generateRequiest()
    @executor.execute request, =>
      callback(command.processResponse())