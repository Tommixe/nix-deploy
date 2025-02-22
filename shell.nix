# https://status.nixos.org (nixpkgs-unstable)
{  
  pkgs ? import <nixpkgs> { config.allowUnfree = true; },
  ...
}: 

let

  python-packages = pkgs.python3.withPackages (p: with p; [
    jinja2
    kubernetes
    netaddr
    rich
    proxmoxer
    pip
  ]);

in
pkgs.mkShell {
  buildInputs = with pkgs; [
    ansible
    ansible-lint
    bmake
    diffutils
    docker
    docker-compose
    git
    iproute2
    jq
    nano
    neovim
    openssh
    p7zip
    pre-commit
    shellcheck
    opentofu
    yamllint
    sshpass
    sops
    ssh-to-age
    gnupg
    age
    opentofu
    python-packages
  ];
}


