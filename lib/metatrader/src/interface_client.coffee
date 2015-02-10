module.exports = class InterfaceClient

  send: (command, callback, error) ->
    throw new Exception('InterfaceClient require implements method send(command, callback, error)')