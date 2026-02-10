# Shell configuration for Home Manager

{
  programs.bash = {
    enable = true;

    shellOptions = [
      "autocd"
    ];

    initExtra = ''
      stty -ixon # don't freeze on ctrl+s
    '';
  };

  home.shellAliases = {
    lg = "lazygit";
  };
}
