{ pkgs, xdg, ... }:

{
  home.packages = with pkgs.kdePackages; [
    kalk                    # Calculator
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
