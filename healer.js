module.exports = function (creep)
{
  var target = creep.pos.findNearest(Game.MY_CREEPS, {filter: function (item) {return item.hits < item.hitsMax && item.id != creep.id}});

  if(target && creep.getActiveBodyparts(Game.HEAL))
  {
    console.log(target);
    console.log('heal move', creep.moveTo(target));
    console.log('heal heal', creep.heal(target));
  }
  else
  {
    target = creep.pos.findNearest(Game.MY_CREEPS, {filter: function (item) {return item.memory.role == 'guard'}});

    if (!target)
      target = creep.pos.findNearest(Game.MY_SPAWNS);


    creep.moveTo(target);
  }
};
