module.exports = ->
  class Creep extends Body()

    constructor: (@name, @lvl) ->
      super()

      @_creep = Game.creeps[@name]
      @Tick()

    Work: (target) ->
      if not target?
        return

      if @_creep.getActiveBodyparts Game.HEAL
        @_creep.heal target
      if @_creep.getActiveBodyparts(Game.WORK) and target.energy?
        @_creep.harvest target
      if @_creep.getActiveBodyparts(Game.CARRY) and target.energy?
        @_creep.pickup target

    MoveTo: (target) ->
      if @_creep.pos.isNearTo target
        return false
      if (res = @_creep.moveTo(target)) < 0
        return false

      true

    GoHome: ->
      target = @_creep.pos.findNearest Game.MY_SPAWNS
      @MoveTo target
      target

    DeserializeTarget: (targetId, targetType) ->
      target = @_creep.room.find(targetType,
        filter:
          id: targetId
      )[0]

      if not target
        return false

      target

    @CountCreeps: (type) ->
      creeps = Game.spawns.Spawn1.room.find Game.MY_CREEPS

      if not type
        return creeps.length

      i = 0
      for creep in creeps when creep.name[0] is type[0]
        i++

      i

    @Get: (name, lvl) ->
      new (require(@GetNameType(name)))(name, lvl)

    @GetNameType: (name) ->
      isNumeric = (n) -> !isNaN(parseFloat(n)) and isFinite(n)
      for c, i in name
        if isNumeric c
          return name[0...i]


Body = require('Body')
