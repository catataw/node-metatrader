module.exports = class InterfaceCommand

  generateRequest: ->
    throw new Exception('InterfaceCommand require implements method generateRequest()')

  stopReadCallback: (buffer) ->
    throw new Exception('InterfaceCommand require implements method stopReadCallback(buffer)')

  processResponse: (response) ->
    throw new Exception('InterfaceCommand require implements method processResponse(response)')