
class Spawner

  constructor: (@name) ->
    @_spawn = Game.spawns[@name]

    if @ModeratePopulation()
      @TrySpawn()

  ModeratePopulation: ->
    count = 0
    while Creep.CountCreeps(order[Memory.nextCreepIdx]) >= maxPop[Memory.nextCreepIdx]
      Memory.nextCreepIdx++
      if Memory.nextCreepIdx >= order.length
        Memory.nextCreepIdx = 0
        count++
        # Avoid infinite loop
        if count >= 2
          return false
    true

  TrySpawn: ->
    if not @_spawn.spawning
      if @HasEnergy(order[Memory.nextCreepIdx]) && @Spawn(order[Memory.nextCreepIdx])
        Memory.nextCreepIdx++
        if Memory.nextCreepIdx >= order.length
          Memory.nextCreepIdx = 0

  Spawn: (type) ->
    if (res = @_spawn.createCreep(Body.GetBody(type).body, type + Memory[type])) is type + Memory[type]
      Memory[type]++
      true
    else
      false

  HasEnergy: (type) ->
    Body.GetBodyCost(type) <= @_spawn.energy

#Set memory to know next creep name
Memory.Miner?             || Memory.Miner = 0
Memory.Transporter?       || Memory.Transporter = 0
Memory.Guard?             || Memory.Guard = 0
Memory.Healer?            || Memory.Healer = 0
Memory.Archer?            || Memory.Archer = 0
Memory.Hybrid?            || Memory.Hybrid = 0
Memory.Engineer?          || Memory.Engineer = 0
Memory.SmallTransporter?  || Memory.SmallTransporter = 0

Memory.nextCreepIdx?      || Memory.nextCreepIdx = 0

order = [
  # 'Engineer'
  'Miner'
  'Transporter'
  'Guard'
  'Guard'
  'Healer'
  'Archer'
  'SmallTransporter'
]

maxPop = [
  # 2
  2
  4
  10
  5 #
  5
  5
  4 #
]

module.exports = Spawner
Creep = require('Creep')()
Body = require('Body')()

