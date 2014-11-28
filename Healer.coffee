Creep = require('Creep')

class Healer extends Creep()

  @SetType 'Healer'

  Tick: ->
    target = @GetTargetToHeal() || @GetTargetToFollow()

    if target && @_creep.getActiveBodyparts Game.HEAL
      @MoveTo target
      @Work target
    else
      @GoHome()

  GetTargetToHeal: ->
    targets = @_creep.room.find Game.MY_CREEPS,
      filter: (item) =>
        item.hits < item.hitsMax && item.id != @_creep.id

    for t in targets when Creep().GetNameType(t) in ['Guard', 'Archer', 'Hybrid']
      target = t
      break

    if not target?
      target = targets[0]

    target

  GetTargetToFollow: ->
    @_creep.pos.findNearest Game.MY_CREEPS,
      filter: (item) ->
        Creep().GetNameType(item.name) in ['Guard', 'Archer', 'Hybrid']

module.exports = Healer
