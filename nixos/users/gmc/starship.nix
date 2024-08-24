{ pkgs, ... }:

{

  programs.starship.enable = true;
  programs.starship.settings = {
    add_newline = false;
    character = {
      error_symbol = "[x](bold red)";
    };
    directory = {
      truncation_length = 5;
      format = "[$path]($style)[$lock_symbol]($lock_style) ";
      style = "bold #2b58d4";
    };
    hostname = {
      ssh_only = false;
      format = "<[$hostname]($style)>";
      trim_at = "-";
      style = "bold dimmed white";
      disabled = true;
    };
    git_branch = {
      format = " [$symbol$branch]($style) ";
      symbol = "🌴";
      style = "bold #d4a72b";
    };
    git_commit = {
      commit_hash_length = 8;
      style = "bold white";
    };
    git_status = {
      conflicted = "🤼";
      ahead = "📚×\${count}";
      behind = "🐢 ×\${count}";
      diverged = "😱  📚 ×\${ahead_count} 🐢 ×\${behind_count}";
      untracked = "🛤️  ×\${count}";
      stashed = "📦 ";
      modified = "📝 ×\${count}";
      staged = "🗃️  ×\${count}";
      renamed = "📛 ×\${count}";
      deleted = "🗑️  ×\${count}";
      style = "bright-white";
      format = "$all_status$ahead_behind";
   };
  };
}
