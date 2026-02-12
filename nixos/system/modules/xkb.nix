{ pkgs, ... }:
let
  gmc = pkgs.stdenvNoCC.mkDerivation {
    name = "gmc";
    src = xkb/symbols/gmc;
    dontUnpack = true;
    installPhase = "cp $src $out";
  };
  thinkbook_itl = pkgs.stdenvNoCC.mkDerivation {
    name = "thinkbook-itl";
    src = xkb/geometry/thinkbook-itl;
    dontUnpack = true;
    installPhase = "cp $src $out";
  };
in
{
  console.useXkbConfig = true;
  services.xserver = {
    xkb = {
      extraLayouts = {
        gmc = {
          description = "English (Can/US intl with programming features)";
          languages = [
            "eng"
            "deu"
            "fra"
            "ron"
            "spa"
          ];
          symbolsFile = gmc;
        };
        gmc_thinkbook_itl = {
          description = "English (Can/US intl with programming features)";
          languages = [
            "eng"
            "deu"
            "fra"
            "ron"
            "spa"
          ];
          symbolsFile = gmc;
          geometryFile = thinkbook_itl;
        };
      };
    };
  };
}
