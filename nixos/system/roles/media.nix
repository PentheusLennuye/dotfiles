{ pkgs, ... }:

{
  environment.systemPackages =
    let
      libbluray = pkgs.libbluray.override {
        withAACS = true;
        withBDplus = true;
      };
      myVlc = pkgs.vlc.override { inherit libbluray; }; # rename to avoid shadow
    in
    [
      pkgs.asunder
      pkgs.handbrake
      pkgs.makemkv
      pkgs.playerctl
      myVlc
    ];
}
