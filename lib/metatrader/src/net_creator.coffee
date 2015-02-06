InterfaceCreator = require('./interface_creator.js')
NetClient = require('./net_client.js')
NetExecutor = require('./net_executor.js')

module.exports = class HttpsCreator extends InterfaceCreator

  createClient: (executor) ->
    if !executor
      throw new Exception('HttpsCreator method createClient require executor')

    return new NetClient(executor)

  createExecutor: (options, callback) ->
    return new NetExecutor(options.host, options.port, callback);