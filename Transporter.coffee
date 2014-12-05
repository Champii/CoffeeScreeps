_ = require 'lodash'

Creep = require('Creep')
Miner = require 'Miner'

Memory.energyTarget? || Memory.energyTarget = null

class Transporter extends Creep()

  constructor: (@name, @lvl) ->
    super()

    @_creep.memory.minerId? || @_creep.memory.minerId = 0
    @_creep.memory.state? || @_creep.memory.state = 'pickup'

  Tick: ->
    if @_creep.memory.state is 'pickup'
      if not @FindTarget() and not @miner?
        return @GoHome()
      else if @miner? and not @target?
        @MoveTo @miner
      else
        @MoveTo @target
        @Work @target
        if @_creep.energy is @_creep.energyCapacity
          @_creep.memory.state = 'home'
    else if @_creep.memory.state is 'home'
      @GoHome()
      if not @_creep.energy
        @_creep.memory.state = 'pickup'

  FindTarget: ->
    if @_creep.memory.minerId
      @miner = Game.getObjectById @_creep.memory.minerId
    else
      nbByMiner = ~~(Transporter.CountCreeps() / Miner.CountCreeps()) + 1
      @miner = Game.spawns.Spawn1.pos.findNearest Game.MY_CREEPS,
        filter: (item) ->
          Creep().GetNameType(item.name) is 'Miner' and
            (_.filter Game.creeps, (creep) ->
              creep.memory.minerId? and creep.memory.minerId is item.id).length < nbByMiner

    if @miner? and not @_creep.memory.minerId
      @_creep.memory.minerId =  @miner.id
    else if not @miner?
      @target = null
      return @_creep.memory.minerId =  0

    sources = @miner.pos.findInRange Game.DROPPED_ENERGY, 1

    if not sources.length
      return @target = null

    @target =
      energy: 0

    for t in sources when t.energy > @target.energy
      @target = t

    if @target.energy is 0
      return @target = null

    @target

  GoHome: (max = 0) ->
    ext = @_creep.pos.findNearest Game.MY_STRUCTURES,
      filter: (struct) ->
        struct.structureType is Game.STRUCTURE_EXTENSION and
          struct.energy < struct.energyCapacity

    if ext?
      extPath = @_creep.pos.findPathTo ext

    if (spawn = @_creep.pos.findNearest(Game.MY_SPAWNS))?
      spawnPath = @_creep.pos.findPathTo spawn

    # if spawnPath? and extPath? and (spawnPath.length >= extPath.length or spawn.energy is spawn.energyCapacity)
    if ext? and ext.energy < ext.energyCapacity
      @MoveTo ext
      @_creep.transferEnergy ext
      if @_creep.energy and max < 3
        @GoHome max + 1
    else
      @_creep.transferEnergy super()

  @RealocAll: ->
    nbByMiner = ~~(Transporter.CountCreeps() / Miner.CountCreeps()) + 1
    count = {}
    for name, creep of Game.creeps when Creep().GetNameType(creep.name) is 'Transporter'
      if creep.memory.minerId and not count[creep.memory.minerId]?
        count[creep.memory.minerId] = 1
      else if creep.memory.minerId
        count[creep.memory.minerId]++
      if count[creep.memory.minerId] > nbByMiner
        console.log 'Realocated'
        creep.memory.minerId = 0

Transporter.Init()

module.exports = Transporter
