class MaxPlayersMutatorConfig extends Object
    config(Mutator_MaxPlayersMutator_Config);

var config int MaxPlayersAllowed;

static function int GetMaxPlayersAllowed()
{
    return Clamp(default.MaxPlayersAllowed, 0, MaxInt);
}
