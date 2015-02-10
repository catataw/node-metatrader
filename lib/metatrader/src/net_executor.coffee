net = require('net')

InterfaceExecutor = require('./interface_executor.js')

module.exports = class NetExecutor extends InterfaceExecutor

  connection: undefined
  host: undefined
  port: undefined
  callback: undefined
  buffer: new Buffer(0)

  constructor: (@host, @port) ->

  execute: (request, @stop_read_callback, @callback) ->
    try
      @connection = net.createConnection @port, @host, =>
        @connection.write(@buildRequest(request))
      @connection.on 'error', (error) ->
        console.log('Connection error: %s', error)
      @connection.on 'data', @readConnection.bind(@)
    catch e
      console.log(e)

  buildRequest: (request) ->
    "W#{request}\nQUIT\n"

  readConnection: (data) ->
    @buffer = Buffer.concat([@buffer, data])
    if @stop_read_callback(@buffer)
      @closeConnection()
      @callback(@buffer)

  closeConnection: ->
    @connection.destroy()