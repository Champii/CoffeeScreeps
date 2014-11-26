/*
 *  This module describe the guardians behaviour
 */

var utils = require('utils');

module.exports = function (creep)
{
  // If a global target has been set and guardians are more than enemies, attack
  if (Memory.target
    && Game.spawns.Spawn1.room.find(Game.HOSTILE_CREEPS).length <= utils.countCreep('g')
    && creep.getActiveBodyparts(Game.ATTACK))
  {
    var target = Game.spawns.Spawn1.room.find(Game.HOSTILE_CREEPS, {filter: {id: Memory.target}})[0];

    creep.moveTo(target.pos);
    creep.attack(target);
  }
  // Else go back to the spawn
  else
    creep.moveTo(Game.spawns.Spawn1);

}
