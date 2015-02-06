net = require('net')

InterfaceExecutor = require('./interface_executor.js')

module.exports = class NetExecutor extends InterfaceExecutor

  connection: undefined
  host: undefined
  port: undefined
  callback: undefined

  constructor: (@host, @port) ->

  execute: (request, @callback) ->
    @connection = net.createConnection @port, @host, =>
      @connection.write(@buildRequest(request))
    @connection.on 'data', @readConnection.bind(@)

  buildRequest: (request) ->
    "W#{request},\nQUIT\n"

  readConnection: (data) ->
    @closeConnection()
    @callback(data)

  closeConnection: ->
    @connection.destroy()