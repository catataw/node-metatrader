InterfaceCommand = require('./interface_command.js')
Iconv  = require('iconv').Iconv

module.exports = class QuotesCommand extends InterfaceCommand
  
  struct_header: [
    {name: "bars", size: 4, handler: "readInt32LE"},
    {name: "digits", size: 4, handler: "readInt32LE"},
    {name: "timesign", size: 4, handler: "readInt32LE"}
  ]
  struct_bar: [
    {name: "ctm", size: 4, handler: "readInt32LE"},
    {name: "open", size: 4, handler: "readInt32LE"},
    {name: "high", size: 4, handler: "readInt32LE"},
    {name: "low", size: 4, handler: "readInt32LE"},
    {name: "close", size: 4, handler: "readInt32LE"},
    {name: "vol", size: 8, handler: "readDoubleLE"},
  ]
  offset: 0

  constructor: (@symbol, @period, @from, @to) ->

  generateRequest: ->
    "HISTORYNEW-symbol=#{@symbol}|period=#{@period}|from=#{@from}|to=#{@to}"

  stopReadCallback: (buffer) ->
    (12) + buffer.readInt32LE(0) * (28) <= buffer.length

  processResponse: (response) ->
    result = []
    result.push(fetch.call(@, response, @struct_header))
    count = response.readInt32LE(0)
    for i in [0...count]
      result.push(fetch.call(@, response, @struct_bar))

    return result

  fetch = (response, struct) ->
    struct.reduce (row, item) =>
      row[item.name] = response[item.handler](@offset)
      @offset += item.size
      return row
    , {}