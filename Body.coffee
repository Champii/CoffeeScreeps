module.exports = ->
  class Body

    constructor: ->

      @body = []
      @nextBody = []

      Body.GetBody()
      # {@body, @nextBody} = Body.GetBody()

      # console.log @body
      # for i in [0...@lvl]
      #   @body.push @nextBody

      # @cost = Body.GetBodyCost()

    @SetType: (type) =>
      @type = type

    @GetBodyCost: =>
      if not @type
        return -1

      bodyCosts = {}
      bodyCosts[Game.MOVE] = 50
      bodyCosts[Game.WORK] = 20
      bodyCosts[Game.CARRY] = 50
      bodyCosts[Game.ATTACK] = 100
      bodyCosts[Game.RANGED_ATTACK] = 150
      bodyCosts[Game.HEAL] = 200
      bodyCosts[Game.TOUGH] = 5

      res = 0
      for i in Body.GetBody()
        res += bodyCosts[i]

      res

    @GetBody: (type) =>
      t = @type
      if not t?
        t = type

      bodies =
        miner:
          body: [Game.MOVE, Game.WORK, Game.WORK, Game.WORK, Game.WORK]
          next: [Game.WORK]
        transporter:
          body: [Game.MOVE, Game.MOVE, Game.CARRY, Game.CARRY, Game.CARRY]
          next: [Game.CARRY]
        guard:
          body: [Game.TOUGH, Game.TOUGH, Game.MOVE, Game.MOVE, Game.ATTACK]
          next: [Game.ATTACK]
        healer:
          body: [Game.TOUGH, Game.TOUGH, Game.MOVE, Game.HEAL, Game.MOVE]
          next: [Game.HEAL]

      console.log 'type', t
      bodies[t]

