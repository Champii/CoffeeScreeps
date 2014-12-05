strategy = require 'currentStrategy'

module.exports = ->
  class Body

    constructor: ->

      @body = Body.GetBody @type, @lvl
      @cost = Body.GetBodyCost @type, @lvl

    @Init: ->
      @type = @name
      @::type = @type

    @GetBodyCost: (type = @name, lvl = 0) ->
      b = Body.GetBody(type, lvl)
      res = 0

      for i in b
        res += bodyCosts[i]

      # console.log 'BodyCost', res

      res

    @GetBody: (type = @name, lvl = 0) ->
      b = strategy.GetBody(type)
      res = []
      res.push part for part in b.body
      if b.next.length
        res.push b.next[i % b.next.length] for i in [0...lvl]

      res

bodyCosts = {}
bodyCosts[Game.MOVE] = 50
bodyCosts[Game.WORK] = 20
bodyCosts[Game.CARRY] = 50
bodyCosts[Game.ATTACK] = 100
bodyCosts[Game.RANGED_ATTACK] = 150
bodyCosts[Game.HEAL] = 200
bodyCosts[Game.TOUGH] = 5
