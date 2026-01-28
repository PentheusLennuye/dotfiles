{ pkgs, ... }:
let
  gmc = pkgs.stdenvNoCC.mkDerivation {
    name = "gmc";
    src = xkb/symbols/gmc;
    dontUnpack = true;
    installPhase = "cp $src $out";
  };
in
{
  console.useXkbConfig = true;
  services.xserver = {
    xkb = {
      extraLayouts.gmc = {
        description = "English (Can/US intl with programming features)";
        languages = [
          "eng"
          "fra"
          "deu"
          "ron"
        ];
        symbolsFile = gmc;
      };
    };
  };
}
