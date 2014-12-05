_ = require 'lodash'

bus = require 'Bus'
Defender = require 'Defender'
Creep = require 'Creep'

class Healer extends Defender()

  constructor: (@name, @lvl) ->
    super()

    @_creep.memory.targetId? || @_creep.memory.targetId = 0

    bus.on 'medic', (creep) =>
      if not @_creep.memory.targetId
        @_creep.memory.targetId = creep._creep.id

  Tick: ->
    @GetTargetToHeal() || @GetTargetToFollow()

    # enemy = @GetTargetToAttack()
    # if enemy?
    #   @Attack enemy

    if @target && @_creep.getActiveBodyparts Game.HEAL
      @MoveTo @target
      @Work @target
    else
      @GoHome()

  GetTargetToHeal: ->
    if @_creep.memory.targetId
      @target = Game.getObjectById @_creep.memory.minerId
    else
      @target = @_creep.pos.findNearest Game.MY_CREEPS,
        filter: (item) =>
          item.hits < item.hitsMax and
            item.id != @_creep.id and
            item.id not in _.chain Game.creeps
                    .filter (creep) -> creep.memory.targetId?
                    .map (creep) -> creep.memory.targetId
                    .value()

    if not @target?
      @_creep.memory.targetId = 0

    @target

  GetTargetToFollow: ->
    @target = @_creep.pos.findNearest Game.MY_CREEPS,
      filter: (item) ->
        Creep().GetNameType(item.name) in ['Guard', 'Archer', 'Hybrid']

  # GetTargetToAttack: ->
  #   Game.getObjectById Memory.target

Healer.Init()

module.exports = Healer
