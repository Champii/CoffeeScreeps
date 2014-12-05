strategy = require 'currentStrategy'

class Spawner

  constructor: (@name, @lvl) ->
    @_spawn = Game.spawns[@name]

    @_spawn.memory.nextCreepIdx?      || @_spawn.memory.nextCreepIdx = 0

    if @ModeratePopulation()
      @TrySpawn()

  ModeratePopulation: ->
    count = 0
    while Creep.CountCreeps(strategy.GetNextCreep(@_spawn.memory.nextCreepIdx).type) >= strategy.GetNextCreep(@_spawn.memory.nextCreepIdx).maxPop
      @_spawn.memory.nextCreepIdx++
      if @_spawn.memory.nextCreepIdx >= strategy.orderLength
        @_spawn.memory.nextCreepIdx = 0
        count++
        # Avoid infinite loop
        if count >= 2
          return false
    true

  TrySpawn: ->
    nextCreepType = strategy.GetNextCreep(@_spawn.memory.nextCreepIdx).type
    if not @_spawn.spawning
      if @HasEnergy(nextCreepType) && @Spawn(nextCreepType)
        @_spawn.memory.nextCreepIdx++
        if @_spawn.memory.nextCreepIdx >= strategy.orderLength
          @_spawn.memory.nextCreepIdx = 0

  Spawn: (type) ->
    if (res = @_spawn.createCreep(Body.GetBody(type, @lvl), type + Memory[type])) is type + Memory[type]
      Memory[type]++
      true
    else
      false

  HasEnergy: (type) ->
    Body.GetBodyCost(type, @lvl) <= @_spawn.energy

#Set memory to know next creep name
Memory.Miner?             || Memory.Miner = 0
Memory.Transporter?       || Memory.Transporter = 0
Memory.Guard?             || Memory.Guard = 0
Memory.Healer?            || Memory.Healer = 0
Memory.Archer?            || Memory.Archer = 0
Memory.Hybrid?            || Memory.Hybrid = 0
Memory.Engineer?          || Memory.Engineer = 0
Memory.SmallTransporter?  || Memory.SmallTransporter = 0

module.exports = Spawner

Creep = require('Creep')()
Body = require('Body')()

