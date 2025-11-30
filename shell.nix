# Development shell for building NUR packages
# Usage: nix-shell
# For flake users: nix develop
{ pkgs ? import <nixpkgs> { } }:

import ./devshell.nix { inherit pkgs; }
