{ pkgs, xdg, ... }

{
  xdg.desktopEtnries.joplin-safe = {
    name="Joplin";
    exec="joplin-desktop --disable-gpu --no-sandbox %U";
    terminal="false";
    type="Application";
    icon="@joplinapp-desktop";
    mimeType="x-scheme-handler/joplin";
    comment="Joplin for Desktop No GPU";
    categories = ["Office"];
  }
}
