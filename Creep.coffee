module.exports = ->
  class Creep extends Body()

    constructor: ->
      super()

      @_creep = Game.creeps[@name]
      @Work()

    MoveTo: (target) ->
      if @_creep.pos.isNearTo target
        return false
      if (res = @_creep.moveTo(target)) < 0
        return false

      true

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
        # console.log c, i
        if isNumeric c
          # console.log name[0...i]
          return name[0...i]


Body = require('Body')
