{ config, lib, ... }:
let
  cfg = config.adace.system.security.tpm;
in
with lib;
{
  options.adace.system.security.tpm.enable = mkEnableOption "TPM";
  config = mkIf cfg.enable {
    security.tpm2 = {
      enable = true;
      pkcs11.enable = true;
      abrmd.enable = true;
    };
  };
}
