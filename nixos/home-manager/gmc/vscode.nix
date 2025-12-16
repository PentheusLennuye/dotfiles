{ pkgs, ... }:

{
  programs.vscode = {
    enable = true;
    profiles = {
        default = {
            enableExtensionUpdateCheck = true;
            enableUpdateCheck = true;
            extensions = with pkgs.vscode-extensions; [
                davidanson.vscode-markdownlint
                donjayamanne.githistory
                docker.docker
                golang.go
                james-yu.latex-workshop
                ms-azuretools.vscode-containers
                ms-python.black-formatter
                ms-python.debugpy
                ms-python.isort
                ms-python.pylint
                ms-python.python
                ms-python.vscode-pylance
                ms-vscode.cpptools
                ms-vscode.remote-explorer
                njpwerner.autodocstring
                rust-lang.rust-analyzer
                stkb.rewrap
                streetsidesoftware.code-spell-checker
                vscodevim.vim
            ];
            userSettings = {
              "black-formatter.args" = ["-l 99" "-t py312"];
              "cSpell.language" = "en-CA";
              "editor.inlayHints.enabled" = "off";
              "editor.rulers" = [ 99 120 ];
              "git.openRepositoryInParentFolders" = "never";
              "git.ignoreMissingGitWarning" = true;
              "python.analysis.typeCheckingMode" = "basic";
              "remote.SSH.remotePlatform" = {
                "*.gitpod.io" = "linux";
              };
              "telemetry.telemetryLevel" = "off";
              "terminal.integrated.defaultProfile.linux" = "zsh";
              "terminal.integrated.defaultProfile.osx" = "zsh";
              "update.mode" = "none";
              "window.zoomLevel" = 1;
              "workbench.startupEditor" = "none";
              "workbench.colorTheme" = "Monokai Pro";
              "workbench.iconTheme" = "Monokai Pro Icons";
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
                "editor.renderWhitespace" = "all";
                "editor.acceptSuggestionOnEnter" = "off";
              };
              "[rust]" = {
                "editor.inlayHints.enabled" = "off";
              };
              "[python]" = {
                "editor.defaultFormatter" = "ms-python.black-formatter";
              };
            };
         };
     };
  };
}

# The following must be (AFAIK) set manually:
# 1yib.rust-bundle
# monokai.theme-monokai-pro-vscode
# ms-vscode-remote.vscode-remote-extensionpack
# ms-vscode.makefile-tools
# ms-vscode.remote.remote-ssh
# ms-vscode.remote-containers
# yzhang.markdownall-in-one
