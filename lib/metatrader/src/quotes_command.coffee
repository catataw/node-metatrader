InterfaceCommand = require('./interface_command.js')

module.exports = class QuotesCommand extends InterfaceCommand
  
  @schema: ['direction', 'symbol', 'bid', 'ask', 'date', 'time']
  symbols: undefined

  constructor: (@symbols) ->

  generateRequest: ->
    "QUOTES-#{@symbols.join(',')},"

  stopReadCallback: (buffer) ->
    @buffer.length > 0 && @buffer.toString().search(/^\d{4}\.\d{2}\.\d{2} \d{2}:\d{2}:\d{2}$/m) >= 0

  processResponse: (response) ->
    mappingResponse(
      filterResponse(
        explodeResponse(response.toString())))

  explodeResponse = (response) ->
    response.split("\n").map (row) ->
      row.split(" ")

  filterResponse = (response) =>
    response.filter (row) =>
      row.length == @schema.length

  mappingResponse = (response) =>
    response.map (row) =>
      count = 0
      row.reduce (result, item) =>
        result[@schema[count++]] = item
        result
      , {}
