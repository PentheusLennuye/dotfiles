{ pkgs, ... }:
let
  gmc = pkgs.stdenvNoCC.mkDerivation {
    name = "gmc";
    src = xkb/symbols/gmc;
    dontUnpack = true;
    installPhase = "cp $src $out";
  };
  # gmc = pkgs.stdenvNoCC.mkDerivation {
  #  name = "gmc";
  #   src = xkb/symbols/nixos-gmc;
  #   dontUnpack = true;
  #   installPhase = "cp $src $out";
  # };
  colemak-dh = pkgs.stdenvNoCC.mkDerivation {
    name = "colemak_dh";
    src = xkb/symbols/nixos-gmc_colemak_dh;
    dontUnpack = true;
    installPhase = "cp $src $out";
  };
  na = pkgs.stdenvNoCC.mkDerivation {
    name = "na";
    src = xkb/symbols/nixos-gmc_na;
    dontUnpack = true;
    installPhase = "cp $src $out";
  };
  tarmak1 = pkgs.stdenvNoCC.mkDerivation {
    name = "tarmak1";
    src = xkb/symbols/nixos-gmc_tarmak1_dh;
    dontUnpack = true;
    installPhase = "cp $src $out";
  };
  tarmak2 = pkgs.stdenvNoCC.mkDerivation {
    name = "tarmak2";
    src = xkb/symbols/nixos-gmc_tarmak2_dh;
    dontUnpack = true;
    installPhase = "cp $src $out";
  };
  tarmak3 = pkgs.stdenvNoCC.mkDerivation {
    name = "tarmak3";
    src = xkb/symbols/nixos-gmc_tarmak3_dh;
    dontUnpack = true;
    installPhase = "cp $src $out";
  };
  tarmak4 = pkgs.stdenvNoCC.mkDerivation {
    name = "tarmak4";
    src = xkb/symbols/nixos-gmc_tarmak4_dh;
    dontUnpack = true;
    installPhase = "cp $src $out";
  };
in
{
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
      extraLayouts.gmc_na = {
        description = "Keys not applicable to Canada/US keyboards";
        languages = [
          "eng"
          "fra"
          "deu"
          "ron"
        ];
        symbolsFile = na;
      };
      extraLayouts.gmc_colemak_dh = {
        description = "English (Colemak-DHm with programming features)";
        languages = [
          "eng"
          "fra"
          "deu"
          "ron"
        ];
        symbolsFile = colemak-dh;
      };
      extraLayouts.gmc_tarmak1_dh = {
        description = "English (Tarmak-DHm level 1 with programming features)";
        languages = [
          "eng"
          "fra"
          "deu"
          "ron"
        ];
        symbolsFile = tarmak1;
      };
      extraLayouts.gmc_tarmak2_dh = {
        description = "English (Tarmak-DHm level 2 with programming features)";
        languages = [
          "eng"
          "fra"
          "deu"
          "ron"
        ];
        symbolsFile = tarmak2;
      };
      extraLayouts.gmc_tarmak3_dh = {
        description = "English (Tarmak-DHm level 3 with programming features)";
        languages = [
          "eng"
          "fra"
          "deu"
          "ron"
        ];
        symbolsFile = tarmak3;
      };
      extraLayouts.gmc_tarmak4_dh = {
        description = "English (Tarmak-DHm level 4 with programming features)";
        languages = [
          "eng"
          "fra"
          "deu"
          "ron"
        ];
        symbolsFile = tarmak4;
      };
    };
  };
}
