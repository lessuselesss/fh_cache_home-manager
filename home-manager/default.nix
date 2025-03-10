{
  lib,
  pkgs,
  stateVersion,
  username,
  ...
}:
let
  inherit (pkgs.stdenv) isDarwin isLinux;
in
{
  home = {
    inherit stateVersion;
    inherit username;
    homeDirectory = if isDarwin then "/Users/${username}" else "/home/${username}";

    packages =
      with pkgs;
      [
        cpufetch
        fastfetch
        ipfetch
        onefetch
        micro

        # Added by lessuseless
        aider-chat

        # General packages for development and system management
        alacritty
        aspell
        aspellDicts.en
        bash-completion
        bat
        btop

        pkg-config
        bun
        cmake
        cargo
        deno
        micromamba
        nurl
        uv
        comma
      
        coreutils
        killall
        neofetch
        openssh
        sqlite
        wget
        zip
        nix-direnv
        devenv

        age
        age-plugin-yubikey
        age-plugin-ledger
        gnupg
        libfido2
        pass

        # Cloud-related tools and SDKs
        docker
        docker-compose
      
        # Media-related packages
        emacs-all-the-icons-fonts
        # emacsPackages.exec-path-from-shell
        dejavu_fonts
        ffmpeg
        fd
        font-awesome
        hack-font
        noto-fonts
        noto-fonts-emoji
        meslo-lgs-nf
      
        flyctl
        google-cloud-sdk
        go
        gopls
        #ngrok - unfree
        ssm-session-manager-plugin
        terraform
        terraform-ls
        tflint
      
        # Media-related packages
        emacs-all-the-icons-fonts
        imagemagick
        dejavu_fonts
        ffmpeg
        fd
        font-awesome
        glow
        hack-font
        jpegoptim
        meslo-lgs-nf
        noto-fonts
        noto-fonts-emoji
        pngquant
      
        # PHP
        php82
        php82Packages.composer
        php82Packages.php-cs-fixer
        php82Extensions.xdebug
        php82Packages.deployer
        phpunit
      
        # Node.js development tools
        fzf
        nodePackages.live-server
        nodePackages.nodemon
        nodePackages.prettier
        nodePackages.npm
        nodejs
      
        # Source code management, Git, GitHub tools
        gh
      
        # Text and terminal utilities
        htop
        hunspell
        iftop
        jetbrains-mono
        #jetbrains.phpstorm - unfree
        jq
        ripgrep
        #slack - unfree
        tree
        pstree
        tmux
        #unrar - also 'un-free'
        unzip
        zsh-powerlevel10k
      
        # Python packages
        black
        python3
        virtualenv

      ]
      ++ lib.optionals isLinux [
        ramfetch
      ]
      ++ lib.optionals isDarwin [
        m-cli
        nix-darwin
      ];
    sessionVariables = {
      EDITOR = "micro";
      SYSTEMD_EDITOR = "micro";
      VISUAL = "micro";
    };
  };

  # Workaround home-manager bug
  # - https://github.com/nix-community/home-manager/issues/2033
  news = {
    display = "silent";
    entries = lib.mkForce [ ];
  };

  nix = {
    package = pkgs.nixVersions.latest;
  };

  programs = {
    home-manager.enable = true;
    micro = {
      enable = true;
      settings = {
        autosu = true;
        diffgutter = true;
        paste = true;
        rmtrailingws = true;
        savecursor = true;
        saveundo = true;
        scrollbar = true;
        scrollbarchar = "░";
        scrollmargin = 4;
        scrollspeed = 1;
      };
    };
  };
}
