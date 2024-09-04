{ pkgs, ... }:

{
  programs.vscode = {
    enable = true;
    enableUpdateCheck = true;
    enableExtensionUpdateCheck = true;
    extensions = with pkgs.vscode-extensions; [
      davidanson.vscode-markdownlint
      golang.go
      james-yu.latex-workshop
      ms-vscode.cpptools
      ms-python.python
      rust-lang.rust-analyzer
      stkb.rewrap
      vscodevim.vim
    ];
    userSettings = {
      "editor.rulers" = [ 80 120 ];
      # "window.titleBarStyle" = "custom";  # crash stop
      "update.mode" = "none";
      "[latex]" = {
        "editor.wordWrap" = "on";
      };
      "[makefile]" = {
        "editor.insertSpaces" = false;
        "editor.detectIndentation" = false;
      };
      "[markdown]" = {
        "editor.formatOnSave" = true;
        "editor.wordWrap" = "on";
        "editor.renderWhitespace" = "on";
        "editor.acceptSuggestionOnEnter" = "off";
      };
      "flake8.args" = [
        "--max-line-length=79"
        "--ignore=E402,W503"
      ];
    };
  };
}

# The following must be (AFAIK) set manually:
# 1yib.rust-bundle
# monokai.theme-monokai-pro-vscode
# ms-vscode-remote.vscode-remote-extensionpack
