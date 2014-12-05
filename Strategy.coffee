_ = require 'lodash'

class Strategy

  GetNextCreep: (id) ->
    @order[id]

  GetBody: (type) ->
    _.findWhere @order, type: type


module.exports = Strategy
