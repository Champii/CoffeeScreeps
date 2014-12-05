Strategy = require 'Strategy'

class Strategy1 extends Strategy

  constructor: ->
    @order =
      '0':
        type: 'Miner'
        maxPop: 5
        body: [Game.WORK, Game.WORK, Game.WORK, Game.WORK, Game.MOVE]
        next: []
      '1':
        type: 'Transporter'
        maxPop: 20
        body: [Game.CARRY, Game.CARRY, Game.CARRY, Game.MOVE, Game.MOVE]
        next: []
      '4':
        type: 'Guard'
        maxPop: 10
        body: [Game.TOUGH, Game.MOVE, Game.ATTACK, Game.MOVE, Game.ATTACK]
        next: [Game.MOVE, Game.ATTACK]
      '5':
        type: 'Healer'
        maxPop: 10
        body: [Game.TOUGH, Game.MOVE, Game.HEAL, Game.MOVE, Game.HEAL]
        next: [Game.MOVE, Game.HEAL]
      '6':
        type: 'Archer'
        maxPop: 10
        body: [Game.TOUGH, Game.MOVE, Game.RANGED_ATTACK, Game.MOVE, Game.RANGED_ATTACK]
        next: [Game.MOVE, Game.RANGED_ATTACK]
      '7':
        type: 'Engineer'
        maxPop: 1
        body: [Game.MOVE, Game.WORK, Game.WORK, Game.CARRY, Game.CARRY]
        next: [Game.MOVE, Game.CARRY]
      # '8':
      #   type: 'SmallTransporter'
      #   maxPop: 10
      #   body: [Game.CARRY, Game.MOVE]
      #   next: [Game.CARRY]
      # '9':
      #   type: 'Hybrid'
      #   maxPop: 5
      #   body: [Game.MOVE, Game.MOVE, Game.ATTACK, Game.RANGED_ATTACK]
      #   next: [Game.MOVE, Game.RANGED_ATTACK]
    @order[2] = @order[0]
    @order[3] = @order[1]

    @orderLength = 8

module.exports = Strategy1
