{ pkgs, ... }:

{

  programs.starship.enable = true;
  programs.starship.settings = {
    format =  "[░▒▓](#a3aed2)" +
      "[  ](bg:#a3aed2 fg:#090c0c)" +
      "[](bg:#769ff0 fg:#a3aed2)$hostname$directory" +
      "[](fg:#769ff0 bg:#394260)$git_branch$git_status" +
      "[](fg:#394260 bg:#212736)$c$golang$helm$kubernetes$lua$nix_shell$python$rust" +
      "[](fg:#212736 bg:#1d2230)$time" +
      "[](fg:#1d2230)\n$character";
    directory = {
      truncation_length = 3;
      truncation_symbol = "…/";
      format = "[$path]($style)";
      style = "fg:#e3e5e5 bg:#769ff0";
    };
    directory.substitutions = {
      "Documents" = "󰈙 ";
      "Downloads" = " ";
      "Music" = " ";
      "Pictures" = " ";
    };
    git_branch = {
      symbol = "";
      style = "bg:#394260";
      format = "[[ $symbol $branch ](fg:#769ff0 bg:#394260)]($style)";
    };
    git_status = {
      style = "bg:#394260";
      format = "[[($all_status$ahead_behind )](fg:#769ff0 bg:#394260)]($style)";
    };
    c = {
      symbol = "";
      style = "bg:#212736";
      format = "[[ $symbol ($version) ](fg:#769ff0 bg:#212736)]($style)";
    };
    golang = {
      symbol = "";
      style = "bg:#212736";
      format = "[[ $symbol ($version) ](fg:#769ff0 bg:#212736)]($style)";
    };
    helm = {
      symbol = "⎈";
      style = "bg:#212736";
      format = "[[ $symbol ($version) ](fg:#769ff0 bg:#212736)]($style)";
    };
    hostname = {
      format = "[$hostname]($style)";
      ssh_only = true;
      style = "bg:#a3aed2 fg:#090c0c";
    };
    kubernetes = {
      symbol = "⎈";
      style = "bg:#212736";
      format = "[[ $symbol ($version) ](fg:#769ff0 bg:#212736)]($style)";
    };
    lua = {
      symbol = "🌙";
      style = "bg:#212736";
      format = "[[ $symbol ($version) ](fg:#769ff0 bg:#212736)]($style)";
    };
    nix_shell = {
      symbol = "";
      style = "bg:#212736";
      format = "[[ $symbol ($version) ](fg:#769ff0 bg:#212736)]($style)";
    };
    python = {
      symbol = "🐍";
      style = "bg:#212736";
      format = "[[ $symbol ($version) ](fg:#769ff0 bg:#212736)]($style)";
    };
    rust = {
      symbol = "🦀";
      style = "bg:#212736";
      format = "[[ $symbol ($version) ](fg:#769ff0 bg:#212736)]($style)";
    };
    time = {
      disabled = false;
      time_format = "%R"; # Hour:Minute Format
      style = "bg:#1d2230";
      format = "[[  $time ](fg:#a0a9cb bg:#1d2230)]($style)";
    };
  };
}
