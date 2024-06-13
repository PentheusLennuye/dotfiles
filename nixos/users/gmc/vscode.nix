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
      "window.titleBarStyle" = "custom";  # crash stop
      "editor.rulers" = [ 80 120 ];
    };
  };
}

# The following must be (AFAIK) set manually:
# 1yib.rust-bundle
# monokai.theme-monokai-pro-vscode
# ms-vscode-remote.vscode-remote-extensionpack
