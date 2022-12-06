class MaxPlayersMutator extends ROMutator
    config(Mutator_MaxPlayersMutator);

function PreBeginPlay()
{
    super.PreBeginPlay();

    WorldInfo.Game.MaxPlayersAllowed = class'MaxPlayersMutatorConfig'.static.GetMaxPlayersAllowed();
    WorldInfo.Game.MaxPlayers = class'MaxPlayersMutatorConfig'.static.GetMaxPlayersAllowed();

    SetAds();
    SetTimer(5.0, True, 'SetAds');
}

// Clamps server advertisement so that it never shows more than 64 max player slots.
// If the server has more than 64 players in it, 64/64 is advertised.
// Otherwise the real player number is advertised e.g. 18/64.
final function SetAds()
{
    local ROGameInfo ROGI;
    local OnlineGameInterface GameInterface;
    local ROOnlineGameSettingsCommon GameSettings;
    local int NumOpenPublicConnections;
    local int NumPublicConnections;

    ROGI = ROGameInfo(WorldInfo.Game);
    GameInterface = ROGI.GameInterface;
    GameSettings = ROOnlineGameSettingsCommon(GameInterface.GetGameSettings(ROGI.PlayerReplicationInfoClass.default.SessionName));

    NumPublicConnections = Clamp(GameSettings.NumPublicConnections, 0, 64);
    NumOpenPublicConnections = Clamp(NumPublicConnections - ROGI.GetNumPlayers(), 0, 64);

    // `log("GameSettings.NumOpenPublicConnections" @ GameSettings.NumOpenPublicConnections);
    // `log("NumPublicConnections" @ NumPublicConnections);
    // `log("NumOpenPublicConnections" @ NumOpenPublicConnections);

    GameSettings.PlayerRatio = (NumPublicConnections - NumOpenPublicConnections) / NumPublicConnections;
    GameSettings.NumOpenPublicConnections = NumOpenPublicConnections;
    GameSettings.NumPublicConnections = NumPublicConnections;

    GameInterface.UpdateOnlineGame(ROGI.PlayerReplicationInfoClass.default.SessionName, GameSettings);
}

function NotifyLogin(Controller NewPlayer)
{
    SetAds();
    super.NotifyLogin(NewPlayer);
}
