#Set memory to know next creep name
if not Memory.Miner?
  Memory.Miner = 0
if not Memory.Transporter?
  Memory.Transporter = 0
if not Memory.Guard?
  Memory.Guard = 0
if not Memory.Healer?
  Memory.Healer = 0
if not Memory.Archer?
  Memory.Archer = 0

if not Memory.nextCreepIdx?
  Memory.nextCreepIdx = 0

class Spawner

  constructor: (@name) ->
    @_spawn = Game.spawns[@name]

    order = [
      'Miner'
      'Transporter'
      'Archer'
      'Healer'
      'Guard'
    ]

    maxPop = [
      2
      2
      3
      3
      3
    ]

    count = 0
    while Creep.CountCreeps(order[Memory.nextCreepIdx]) >= maxPop[Memory.nextCreepIdx]
      Memory.nextCreepIdx++
      if Memory.nextCreepIdx >= order.length
        Memory.nextCreepIdx = 0
        count++
        # Avoid infinite loop
        if count >= 2
          return

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

module.exports = Spawner
Creep = require('Creep')()
Body = require('Body')()
