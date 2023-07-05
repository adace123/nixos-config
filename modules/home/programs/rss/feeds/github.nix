_: let
  releases = {
    helix = "helix-editor/helix";
    hyprland = "hyprwm/Hyprland";
    nushell = "nushell/nushell";
  };
in {
  formatted-releases = builtins.attrValues (builtins.mapAttrs (title: value: {
      title = "${title} - GitHub Releases";
      url = "https://github.com/${value}/releases.atom";
      tags = ["github-releases"];
    })
    releases);
}
