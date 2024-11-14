<!-- markdownlint-disable MD001 MD031 -->
# Ansible

NixOS is my source of truth for which these Ansible playbooks are derived. I
do use MacOS, Windows (for games), Raspberry Pi. For these, I feel incompetent
in using Nix packages for now.

## MacOS

As of Q4 2024, Mac OS X 12.7 is no longer supported. Homebrew likewise does not
support 12.7. Computers such as Early 2015 MacBook Pros would be cast out.
However, OpenCore Legacy Patcher can rescue such machines and enable later
operating system versions.

MacOS ansible _loves_ Homebrew so OCLP it is.

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
4. Install Homebrew
   ```sh
   URL=https://raw.githubusercontent.com/Homebrew
   /bin/bash -c "$(curl -fsSL ${URL}/install/HEAD/install.sh)"
   ```

### MacOS TODO

- rust
- golang
- other linters for python, rust, golang, c, etc

