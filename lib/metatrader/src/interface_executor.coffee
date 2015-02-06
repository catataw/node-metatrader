module.exports = class InterfaceExecutor

  execute: (request) ->
    throw new Exception('InterfaceExecutor require implements method execute(request)')