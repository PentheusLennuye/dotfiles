{ pkgs, ... }:

{

  environment.systemPackages = with pkgs; [
    texliveMedium
    pandoc
 ];
}
