Creep = require('Creep')

class Healer extends Creep()

  @SetType 'Healer'

  constructor: (@name, @lvl) ->
    @type = 'Healer'

    super()

  Work: ->
    target = @_creep.pos.findNearest Game.MY_CREEPS,
      filter: (item) =>
        item.hits < item.hitsMax && item.id != @_creep.id

    if target && @_creep.getActiveBodyparts Game.HEAL
      if not @MoveTo target
        @_creep.heal target
    else
      target = @_creep.pos.findNearest Game.MY_CREEPS,
        filter: (item) ->
          item.name[..-2] is 'Guard'

      if not target
        target = @_creep.pos.findNearest Game.MY_SPAWNS

      @MoveTo target

module.exports = Healer
