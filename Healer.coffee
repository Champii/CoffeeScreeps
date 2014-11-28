Creep = require('Creep')

class Healer extends Creep()

  @SetType 'Healer'

  constructor: (@name, @lvl) ->
    @type = 'Healer'

    super()

  Work: ->
    targets = @_creep.room.find Game.MY_CREEPS,
      filter: (item) =>
        item.hits < item.hitsMax && item.id != @_creep.id

    for t in targets when Creep().GetNameType(t) is 'Guard' or Creep().GetNameType(t) is 'Archer'
      target = t

    if not target?
      target = targets[0]

    if target && @_creep.getActiveBodyparts Game.HEAL
      if not @MoveTo target
        @_creep.heal target
    else
      target = @_creep.pos.findNearest Game.MY_CREEPS,
        filter: (item) ->
          Creep().GetNameType(item.name) is 'Guard' or Creep().GetNameType(item.name) is 'Archer'

      if not target
        target = @_creep.pos.findNearest Game.MY_SPAWNS

      @MoveTo target

module.exports = Healer
