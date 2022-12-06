class MaxPlayersMutatorConfig extends Object
    config(Mutator_MaxPlayersMutator_Config);

// Config value that overrides max allowed players.
var private config int MaxPlayersAllowed;

final static function int GetMaxPlayersAllowed()
{
    return Clamp(default.MaxPlayersAllowed, 0, MaxInt);
}
