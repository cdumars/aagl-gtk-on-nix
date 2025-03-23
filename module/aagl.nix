{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.programs.anime-game-launcher;
in {
  imports = [
    (lib.mkRenamedOptionModule ["programs" "an-anime-game-launcher"] ["programs" "anime-game-launcher"])
  ];

  options.programs.anime-game-launcher = {
    enable = mkOption {
      type = types.bool;
      default = false;
      description = ''
        Whether to enable anime-game-launcher.
      '';
    };
    package = mkOption {
      type = types.package;
      default = pkgs.anime-game-launcher;
      description = ''
        anime-game-launcher package to use.
      '';
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [cfg.package];
    networking.mihoyo-telemetry.block = true;
  };
}
