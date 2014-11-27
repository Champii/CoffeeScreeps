class Spawner

  constructor: (@name) ->
    @_spawn = Game.spawns[@name]

    #Set memory to know next creep name
    if not Memory.miner?
      Memory.miner = 0
    if not Memory.transporter?
      Memory.transporter = 0
    if not Memory.guard?
      Memory.guard = 0
    if not Memory.healer?
      Memory.healer = 0

    if not Memory.nextCreepIdx?
      Memory.nextCreepIdx = 0


    nbT = Creep.CountCreeps 'transporter'
    nbM = Creep.CountCreeps 'miner'
    nbG = Creep.CountCreeps 'guard'
    nbH = Creep.CountCreeps 'healer'

    order = [
      'miner'
      'transporter'
      'guard'
      'healer'
    ]

    if not @_spawn.spawning && @Spawn order[Memory.nextCreepIdx]
      Memory.nextCreepIdx++
      if Memory.nextCreepIdx >= order.length
        Memory.nextCreepIdx = 0

  Spawn: (type) ->
    if typeof @_spawn.createCreep(Body.GetBody(type).body, type + Memory[type]) is 'string'
      Memory[type]++
    else
      false

