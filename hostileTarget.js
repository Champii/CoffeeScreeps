module.exports = function ()
{

  if (!Memory.target)
  {
    var target = Game.spawns.Spawn1.pos.findNearest(Game.HOSTILE_CREEPS);

    if (!target)
      return;

    // for (var i in target)
    //   console.log(i, target[i]);
    console.log('Target !', target.id);
    Memory.target = target.id;
  }
  else
  {
    var target = Game.spawns.Spawn1.room.find(Game.HOSTILE_CREEPS, {filter: {id: Memory.target}});

    if (!target.length)
    {
      console.log('Dead', Memory.target);
      Memory.target = null;
    }

  }

  // console.log('Target ?', target);
  // if (target)
  // {
  //   Memory.target = target.id;
  //   for (var i in target)
  //   {
  //     console.log(i, target[i]);
  //   }
  //   console.log('Target !', Memory.target);
  // }
  // else
  //   Memory.target = null;

}
