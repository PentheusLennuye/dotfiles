{ pkgs, xdg, ... }:


{

  home.packages = with pkgs.kdePackages; [
    kcalc
    kde-cli-tools
    kmahjongg
    kpat
  ];

  xdg.desktopEntries.joplin-safe = {
    name="Joplin GPU Safe";
    exec="joplin-desktop --disable-gpu --no-sandbox %U";
    terminal=false;
    type="Application";
    icon="@joplinapp-desktop";
    mimeType=["x-scheme-handler/joplin"];
    comment="Joplin for Desktop Safe for nVidia";
    categories = ["Office"];
  };
}
