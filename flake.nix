{
  description = "Adithya's nix-darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:nix-darwin/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    mac-app-util.url = "github:hraban/mac-app-util";
    nix-homebrew.url = "github:zhaofengli/nix-homebrew";
    homebrew-core = {
      url = "github:homebrew/homebrew-core";
      flake = false;
    };
    homebrew-cask = {
      url = "github:homebrew/homebrew-cask";
      flake = false;
    };
  };

  outputs = inputs @ {
    self,
    nix-darwin,
    nixpkgs,
    mac-app-util,
    nix-homebrew,
    homebrew-core,
    homebrew-cask,
  }: let
    configuration = {
      pkgs,
      config,
      ...
    }: {
      # List packages installed in system profile. To search by name, run:
      # $ nix-env -qaP | grep wget
      environment.systemPackages = with pkgs; [
        zoxide
        mkalias
        neovim
        bun
        obsidian
        telegram-desktop
        qbittorrent-enhanced
      ];

      nixpkgs.config.allowUnfree = true;
      security.pam.services.sudo_local.touchIdAuth = true;

      homebrew = {
        enable = true;
        taps = [
          "TheBoredTeam/boring-notch"
        ];
        brews = [
          "openjdk@17"
          "spicetify-cli"
          "typst"
          "mas"
          "webp"
          "prettierd"
          "tmux"
          "lazygit"
          "rbenv"
          "uv"
          "stow"
          "gnupg"
          "pinentry-mac"
          "starship"
          "gh"
        ];
        casks = [
          "discord@canary"
          "android-commandlinetools"
          "android-platform-tools"
          "flutter"
          "gimp"
          "1password"
          "raycast"
          "aldente"
          "vesktop"
          "roblox"
          "zed"
          "bitwarden"
          "boring-notch"
          "macfuse"
          "veracrypt"
          "jellyfin"
          "google-drive"
          "spotify"
          "whatsapp"
          "appcleaner"
          "antigravity"
          "rectangle"
          "openmtp"
          "brave-browser"
          "protonvpn"
          "vlc"
          "localsend"
          "ghostty"
        ];
        masApps = {
        };
        global.autoUpdate = false;
        onActivation = {
          cleanup = "zap";
          autoUpdate = true;
          upgrade = true;
        };
      };

      system.primaryUser = "adxthya";
      programs.fish.enable = true;

      # Necessary for using flakes on this system.
      nix.settings.experimental-features = "nix-command flakes";

      # Enable alternative shell support in nix-darwin.
      # programs.fish.enable = true;

      # Set Git commit hash for darwin-version.
      system.configurationRevision = self.rev or self.dirtyRev or null;

      # Used for backwards compatibility, please read the changelog before changing.
      # $ darwin-rebuild changelog
      system.stateVersion = 6;

      # The platform the configuration will be used on.
      nixpkgs.hostPlatform = "aarch64-darwin";
    };
  in {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#hope
    darwinConfigurations."hope" = nix-darwin.lib.darwinSystem {
      modules = [
        configuration
        mac-app-util.darwinModules.default
        nix-homebrew.darwinModules.nix-homebrew
        {
          nix-homebrew = {
            # Install Homebrew under the default prefix
            enable = true;

            # Apple Silicon Only: Also install Homebrew under the default Intel prefix for Rosetta 2
            enableRosetta = true;

            # User owning the Homebrew prefix
            user = "adxthya";

            # Automatically migrate existing Homebrew installations
            autoMigrate = true;
          };
        }
      ];
    };
  };
}
