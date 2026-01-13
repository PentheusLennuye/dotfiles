{ ... }:
let
  dir_bg = "#66b2ff";
  dir_fg = "#e5e5e5";
  git_bg = "#004c99";
  git_fg = "#99ccff";
  dev_bg = "#212736";
  dev_fg = "#769ff0";
  os_bg = "#99ccff";
  os_fg = "#001193";
  starshipFormatRaw = [
    "[](fg:${os_bg})$os"
    "[](fg:${os_bg} bg:${dir_bg})$directory"
    "[](fg:${dir_bg} bg:${git_bg})$nix_shell"
    "$git_branch"
    "$git_status"
    "[](fg:${git_bg})[$python$golang$rust$lua$haskell$c$cpp$package](fg:${dev_fg} bg:${dev_bg})"
    "\n$character"
  ];
  starshipFormat = builtins.concatStringsSep "" starshipFormatRaw;
in
{
  programs.starship = {
    enable = true;
    settings = {
      format = starshipFormat;

      # ┌─────────────────────────────────────────────────────────────────────────────────────────┐
      # │                                                                                         │
      # │ OS                                                                                      │
      # │ Operating system symbol                                                                 │
      # │                                                                                         │
      # └─────────────────────────────────────────────────────────────────────────────────────────┘

      os = {
        disabled = false;
        format = "[$symbol](fg:${os_fg} bg:${os_bg})";
      };

      os.symbols = {
        Alpine = " ";
        Debian = " ";
        FreeBSD = " ";
        Kali = " ";
        Macos = " ";
        Mint = " ";
        NetBSD = " ";
        NixOS = " ";
        OpenBSD = "󰈺 ";
        Pop = " ";
        Raspbian = " ";
        Ubuntu = " ";
        Windows = "󰍲 ";
      };

      # ┌─────────────────────────────────────────────────────────────────────────────────────────┐
      # │                                                                                         │
      # │ Directory Configuration                                                                 │
      # │                                                                                         │
      # └─────────────────────────────────────────────────────────────────────────────────────────┘

      directory = {
        style = "fg:${dir_fg} bg:${dir_bg}";
        format = "[ $path ]($style)";
        truncation_length = 3;
        truncation_symbol = "…/";
      };

      directory.substitutions = {
        "Documents" = "󰈙 ";
        "Downloads" = " ";
        "Music" = " ";
        "Pictures" = " ";
      };

      # ┌─────────────────────────────────────────────────────────────────────────────────────────┐
      # │                                                                                         │
      # │ Git Configuration                                                                       │
      # │                                                                                         │
      # └─────────────────────────────────────────────────────────────────────────────────────────┘

      git_branch = {
        symbol = "";
        format = "[ $symbol $branch ](fg:${git_fg} bg:${git_bg})";
      };

      git_status = {
        format = "[($all_status$ahead_behind )](fg:${git_fg} bg:${git_bg})";
      };

      # ┌─────────────────────────────────────────────────────────────────────────────────────────┐
      # │                                                                                         │
      # │ Development Environment Configuration                                                   │
      # │                                                                                         │
      # └─────────────────────────────────────────────────────────────────────────────────────────┘

      nix_shell = {
        format = "[ $symbol](bg:${git_fg})";
        symbol = " ";
      };

      nodejs = {
        format = " $symbol";
      };

      python = {
        format = " $symbol";
      };

      rust = {
        format = " $symbol";
      };

      golang = {
        format = " $symbol";
      };

      package = {
        format = "[$symbol $version](208)";
      };

      # ┌─────────────────────────────────────────────────────────────────────────────────────────┐
      # │                                                                                         │
      # │ Disabled Modules                                                                        │
      # │                                                                                         │
      # └─────────────────────────────────────────────────────────────────────────────────────────┘

      time = {
        disabled = true;
        time_format = "%R"; # Hour:Minute Format
        style = "bg:#1d2230";
        format = "[  $time ](fg:#a0a9cb bg:#1d2230)";
      };
    };
  };
}
