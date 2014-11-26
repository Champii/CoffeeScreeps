module.exports = function (creep)
{
    if (creep.energy < creep.energyCapacity)
    {
        var source = creep.pos.findNearest(Game.SOURCES_ACTIVE)
        creep.moveTo(source);
        creep.harvest(source);
    }
    else
    {
        var spawn = creep.pos.findNearest(Game.MY_SPAWNS)
        creep.moveTo(spawn);
        creep.transferEnergy(spawn);
    }
}
