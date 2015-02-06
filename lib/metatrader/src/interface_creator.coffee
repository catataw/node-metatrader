module.exports = class InterfaceCreator

  createClient: (executor) ->
    throw new Exception('InterfaceCreator require implements method createClient(executor)')

  createExecutor: ->
    throw new Exception('InterfaceCreator require implements method createExecutor()')
