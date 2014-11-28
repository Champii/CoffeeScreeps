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
      new (require(name[..-2]))(name, lvl)

Body = require('Body')
