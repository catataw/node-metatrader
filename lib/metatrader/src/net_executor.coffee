net = require('net')

InterfaceExecutor = require('./interface_executor.js')

module.exports = class NetExecutor extends InterfaceExecutor

  connection: undefined
  host: undefined
  port: undefined
  callback: undefined
  buffer: new Buffer(0)

  constructor: (@host, @port) ->

  execute: (request, @stop_read_callback, @callback, @error) ->
    try
      if typeof @error != 'function'
        @error = ->
      @connection = net.createConnection @port, @host, =>
        @connection.write(@buildRequest(request))
      @connection.on 'error', (error) =>
        console.log('Connection error: %s', error)
        @error(error)
      @connection.on 'data', @readConnection.bind(@)
    catch e
      console.log(e)
      @error(e)

  buildRequest: (request) ->
    "W#{request}\nQUIT\n"

  readConnection: (data) ->
    try
      @buffer = Buffer.concat([@buffer, data])
      if @stop_read_callback(@buffer)
        @closeConnection()
        @callback(@buffer)
    catch e
      @error(e)

  closeConnection: ->
    try
      @connection.destroy()
    catch e
      @error(e)