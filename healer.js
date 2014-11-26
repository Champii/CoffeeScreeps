/*
 *  This module describe the healers behaviour
 */

module.exports = function (creep)
{
  var target = creep.pos.findNearest(Game.MY_CREEPS, {filter: function (item) {return item.hits < item.hitsMax && item.id != creep.id}});

  // If their is still a HEAL part in creep body and a target set
  if(target && creep.getActiveBodyparts(Game.HEAL))
  {
    creep.moveTo(target);
    creep.heal(target);
  }
  // Else, follow the nearest guardian
  else
  {
    target = creep.pos.findNearest(Game.MY_CREEPS, {filter: function (item) {return item.memory.role == 'guard'}});

    // If no guardians, return to spawn
    if (!target)
      target = creep.pos.findNearest(Game.MY_SPAWNS);


    creep.moveTo(target);
  }
};
