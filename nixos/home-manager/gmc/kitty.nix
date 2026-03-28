{ ... }:
{
  programs = {
    kitty = {
      enable = true;
      keybindings = {
        "ctrl+c" = "copy_or_interrupt";
        "ctrl+v" = "paste_from_clipboard";
      };
      settings = {
        background_opacity = "0.7";
        font_family = "JetBrains mono";
        font_size = "11.5";
        shell = "zsh";
      };
    };
  };
}
