module.exports = ->
  class Body

    constructor: ->

      {body: @body, next: @nextBody} = Body.GetBody @type

      for i in [0...@lvl]
        @body.push @nextBody

      @cost = Body.GetBodyCost @type

    @SetType: (type) =>
      @type = type
      @::type = type

    @GetBodyCost: (type) =>
      t = @type || type

      bodyCosts = {}
      bodyCosts[Game.MOVE] = 50
      bodyCosts[Game.WORK] = 20
      bodyCosts[Game.CARRY] = 50
      bodyCosts[Game.ATTACK] = 100
      bodyCosts[Game.RANGED_ATTACK] = 150
      bodyCosts[Game.HEAL] = 200
      bodyCosts[Game.TOUGH] = 5

      res = 0

      for i in Body.GetBody(t).next
        res += bodyCosts[i]

      res

    @GetBody: (type) =>
      t = @type || type

      bodies =
        Miner:
          body: [Game.MOVE, Game.MOVE, Game.WORK, Game.WORK, Game.WORK]
          next: [Game.WORK]
        Transporter:
          body: [Game.MOVE, Game.MOVE, Game.CARRY, Game.CARRY, Game.CARRY]
          next: [Game.CARRY]
        Guard:
          body: [Game.TOUGH, Game.TOUGH, Game.MOVE, Game.MOVE, Game.ATTACK]
          next: [Game.MOVE, Game.ATTACK]
        Healer:
          body: [Game.TOUGH, Game.HEAL, Game.MOVE, Game.MOVE, Game.MOVE]
          next: [Game.MOVE, Game.HEAL]
        Archer:
          body: [Game.TOUGH, Game.TOUGH, Game.MOVE, Game.MOVE, Game.RANGED_ATTACK]
          next: [Game.MOVE, Game.RANGED_ATTACK]
        Hybrid:
          body: [Game.TOUGH, Game.MOVE, Game.MOVE, Game.ATTACK, Game.RANGED_ATTACK]
          next: [Game.MOVE, Game.RANGED_ATTACK]

      bodies[t]

