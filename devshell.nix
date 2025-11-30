# Shared development shell configuration
# Used by both shell.nix and flake.nix
{ pkgs }:

pkgs.mkShell {
  packages = with pkgs; [
    nix-build-uncached
    cachix
    nix-prefetch-git
    nix-prefetch-url
  ];
  shellHook = ''
    echo "NUR packages development shell"
    echo "Available commands:"
    echo "  nix-build -A <package>     - Build a package"
    echo "  nix-build ci.nix -A cacheOutputs - Build all cacheable packages"
    echo "  nix-env -f . -qa '*'       - List all packages"
  '';
}
