module.exports = class InterfaceExecutor

  execute: (request, stop_read_callback, callback, error) ->
    throw new Exception('InterfaceExecutor require implements method execute(request, stop_read_callback, callback, error)')