# Ansible

NixOS is my source of truth for which these Ansible playbooks are derived. I
do use MacOS, Windows (for games), Raspberry Pi. For these, I feel incompetent
in using Nix packages for now.

## MacOS

MacOS ansible _loves_ brew. However, "vintage" Macs (such as my early 2015
slabtop) are cast aside despite them being perfectly acceptable development
machines. Ansible in this case will not use brew but other means.

MacOS will need an updated Python to install Ansible. Set up the system thus:


1. Install Python from a DMG as the year requires (in this example, 3.11)
2. Do not forget to install the certificate store
   ```sh
   PYVER=3.11
   sudo /Applications/Python\ $PYVER/Install\ Certificates.command
   ```
3. Install ansible
   ```sh
   python3 -m pip install --user ansible
   ```

### MacOS TODO

- jq
- pipx
- docker
- VSCode
- lua
- ruby  <http://rvm.io>
- rust
- golang
- exa
- starship
- Docker
- Nerdfonts
- neovim
- markdownlint  # gem install --user-install mdl
- marksman
- jedi-language-server
- other linters for python, rust, golang, c, etc

