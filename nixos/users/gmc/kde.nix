{ pkgs, config, xdg, ... }:


{

  home.file = {
    ".config/kactivitymanagerdrc".source = kde/kactivitymanagerdrc;
    ".config/kglobalshortcutsrc".source = kde/kglobalshortcutsrc;
    ".config/kwinrc".source = kde/kwinrc;
    ".config/kwinrulesrc".source = kde/kwinrulesrc;
    ".config/kxkbrc".source = kde/kxkbrc;
  };

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
