/*
 *  This module find and save a global target for guardians
 */

module.exports = function ()
{

  // If no target set
  if (!Memory.target)
  {
    var target = Game.spawns.Spawn1.pos.findNearest(Game.HOSTILE_CREEPS);

    if (!target)
      return;

    Memory.target = target.id;
  }
  // If target set, check if alive
  else
  {
    var target = Game.spawns.Spawn1.room.find(Game.HOSTILE_CREEPS, {filter: {id: Memory.target}});

    // If not alive, reset global target
    if (!target.length)
    {
      console.log('Dead', Memory.target);
      Memory.target = null;
    }

  }
};
