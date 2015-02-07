net = require('net')

InterfaceExecutor = require('./interface_executor.js')

module.exports = class NetExecutor extends InterfaceExecutor

  connection: undefined
  host: undefined
  port: undefined
  callback: undefined
  buffer: ""

  constructor: (@host, @port) ->

  execute: (request, @callback) ->
    @connection = net.createConnection @port, @host, =>
      @connection.write(@buildRequest(request))
    @connection.on 'data', @readConnection.bind(@)

  buildRequest: (request) ->
    "W#{request},\nQUIT\n"

  readConnection: (data) ->
    regexp = /^\d{4}\.\d{2}\.\d{2} \d{2}:\d{2}:\d{2}$/m
    @buffer += data.toString()
    
    if @buffer.search(regexp) >= 0
      @closeConnection()
      @callback(@buffer)

  closeConnection: ->
    @connection.destroy()