module.exports = ->

  class Creep extends Body()

    # Defaults params are a hack
    # allowing to set them in child,
    # and permitting to avoid sending them to super()
    constructor: (@name = @name, @lvl = @lvl) ->
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

    @CountCreeps: (type) ->
      t = type || @type
      if not t
        return Game.creeps.length

      creeps = Game.spawns.Spawn1.room.find Game.MY_CREEPS

      i = 0
      for creep in creeps when @GetNameType(creep.name) is t
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
