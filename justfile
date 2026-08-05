default:
  @just --list

[group('Main')]
update:
  nix flake update

[group('dev')]
lint:
  nix fmt

[group('dev')]
check:
  nix flake check

[group('dev')]
dev:
  nix develop

[group('Main')]
run:
  nix run
