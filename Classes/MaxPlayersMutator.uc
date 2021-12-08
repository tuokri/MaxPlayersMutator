class MaxPlayersMutator extends ROMutator
    config(Mutator_MaxPlayersMutator);

function PreBeginPlay()
{
    super.PreBeginPlay();
    WorldInfo.Game.MaxPlayersAllowed = class'MaxPlayersMutatorConfig'.static.GetMaxPlayersAllowed();
    WorldInfo.Game.MaxPlayers = class'MaxPlayersMutatorConfig'.static.GetMaxPlayersAllowed();
}
