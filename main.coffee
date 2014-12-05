Spawner = require 'Spawner'
Creep = require('Creep')()
Defender = require('Defender')()
Transporter = require 'Transporter'

class Main

  constructor: ->
    @GarbageCollector()
    @InitLvl()
    @InitTarget()
    @InitSpawners()
    @InitCreeps()

  GarbageCollector: ->
    for name, creep of Memory.creeps
      if not Game.creeps[name]?
        delete Memory.creeps[name]

  InitLvl: ->
    @lvl = 0

    # console.log 'Game.structures'
    for k, v of Game.structures when v.structureType is Game.STRUCTURE_EXTENSION
      @lvl++

    # console.log 'lvl', @lvl

  InitTarget: ->
    Transporter.RealocAll()
    Defender.GetGlobalTarget()

  InitSpawners: ->
    @spawners = (new Spawner spawn, @lvl for spawn of Game.spawns)

  InitCreeps: ->
    @creeps = (Creep.Get creep, @lvl for creep of Game.creeps)


main = new Main()
