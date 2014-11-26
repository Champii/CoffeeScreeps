module.exports.getHarvesterBody = function (lvl)
{
    var body = [Game.MOVE, Game.MOVE, Game.CARRY, Game.CARRY, Game.WORK];
    var cost = 220;

    for (var i = 0; i < lvl; i++)
    {
        body.push(Game.WORK);
        cost += 20;
    }

    return({body: body, cost: cost});
}
module.exports.getGuardBody = function (lvl)
{
    var body = [Game.TOUGH, Game.TOUGH, Game.MOVE, Game.MOVE, Game.ATTACK];
    var cost = 220;

    for (var i = 0; i < lvl; i++)
    {
        body.push(Game.ATTACK);
        cost += 100;
    }

    return({body: body, cost: cost});
}

module.exports.getBuilderBody = function (lvl)
{
    var body = [Game.MOVE, Game.MOVE, Game.CARRY, Game.CARRY, Game.WORK];
    var cost = 220;

    for (var i = 0; i < lvl; i++)
    {
        body.push(Game.CARRY);
        cost += 50;
    }

    return({body: body, cost: cost});
}

module.exports.getHealerBody = function (lvl)
{
    var body = [Game.TOUGH, Game.TOUGH, Game.MOVE, Game.HEAL, Game.MOVE];
    var cost = 310;

    for (var i = 0; i < lvl; i++)
    {
        body.push(Game.HEAL);
        cost += 200;
    }

    return({body: body, cost: cost});
}

module.exports.countCreep = function (type)
{
    var creeps = Game.spawns.Spawn1.room.find(Game.MY_CREEPS);
    if (type == undefined)
        return creeps.length;

    var i = 0;
    for (var i in creeps)
        if (creeps[i].name[0] == type)
            i++;

    console.log(type, i);
    return i;
};
