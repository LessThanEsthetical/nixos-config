{pkgs, ...}: {
  packages = [pkgs.git pkgs.proselint];

  languages.nix.enable = true;
  languages.nix.lsp.enable = true;
  delta.enable = true;
  difftastic.enable = true;

  git-hooks.hooks = {
    alejandra.enable = true;
    deadnix.enable = true;
    flake-checker.enable = true;
    lychee = {
      enable = true;
      settings.flags = "--accept '200, 429'";
    };
    mdsh.enable = true;
  };

  enterTest = ''
    echo "Running tests"
    git --version | grep --color=auto "${pkgs.git.version}"
  '';
}
