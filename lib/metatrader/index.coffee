module.exports = MetaTrader = {}

MetaTrader.InterfaceClient = require('./src/interface_client.js')
MetaTrader.InterfaceCreator = require('./src/interface_creator.js')
MetaTrader.InterfaceExecutor = require('./src/interface_executor.js')
MetaTrader.InterfaceCommand = require('./src/interface_command.js')

MetaTrader.NetClient = require('./src/net_client.js')
MetaTrader.NetCreator = require('./src/net_creator.js')
MetaTrader.NetExecutor = require('./src/net_executor.js')