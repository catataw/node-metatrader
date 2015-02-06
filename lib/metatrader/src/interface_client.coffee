module.exports = class InterfaceClient

  send: (command) ->
    throw new Exception('InterfaceClient require implements method send(command)')