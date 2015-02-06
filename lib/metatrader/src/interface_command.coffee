module.exports = class InterfaceCommand

  generateRequest: ->
    throw new Exception('InterfaceCommand require implements method generateRequest()')

  processResponse: (response) ->
    throw new Exception('InterfaceCommand require implements method processResponse(response)')