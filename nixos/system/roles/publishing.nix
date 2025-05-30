{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    pandoc
    texliveMedium
 ];
}
