net = require('net')

InterfaceExecutor = require('./interface_executor.js')

module.exports = class NetExecutor extends InterfaceExecutor

  connection: undefined
  host: undefined
  port: undefined
  callback: undefined

  constructor: (@host, @port) ->

  execute: (request, @callback) ->
    @createConnection()
    @writeConnection(@buildRequest(request))

  buildRequest: (request) ->
    "W#{request},\nQUIT\n"

  createConnection: ->
    @connection = net.createConnection(@port, @host)
    @connection.on 'data', @readConnection.bind(@)

  readConnection: (data) ->
    @closeConnection()
    @callback(data)

  writeConnection: (request) ->
    @connection.write(request)

  closeConnection: ->
    @connection.destroy()