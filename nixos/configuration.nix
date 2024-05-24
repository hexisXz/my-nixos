# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).


{ config, pkgs, ... }:

{

    imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";
  boot.loader.grub.useOSProber = true;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;
  networking.interfaces.wlan0.useDHCP = true;
  networking.wireless.interfaces = ["wlan0"];

  # Set your time zone.
  time.timeZone = "America/New_York";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the KDE Plasma Desktop Environment.
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.desktopManager.plasma5.enable = true;

  # Configure keymap in X11
  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.


  users.users.hexis = {
    isNormalUser = true;
    description = "hexis";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      kate
      vim
      zsh
      python3
      herbstluftwm
      flatpak
      feh
      alacritty
      xcompmgr
      fzf
      libreoffice
      polybar
      git
      neofetch
      gcc
      wget
      curl
      docker
      podman
      distrobox
      htop
      gimp 
      eza
      dmenu
      networkmanager
      chromium
      kitty
      wofi
      wlr-randr
      wl-clipboard
      hyprpaper
      swww
      waybar
      font-awesome_5
      font-awesome
      font-awesome_4 
      pavucontrol
      nerdfonts
      home-manager
      dvtm
      abduco
    #  thunderbird
    ];
  };


  # flakes 
  nix.settings.experimental-features = [ "nix-command" "flakes" ];  


  services.flatpak.enable = true;

  #hyprland 
  programs.hyprland.enable = true;

  # DWM 
  services.xserver.windowManager.dwm.enable = true;

  services.xserver.windowManager.dwm.package = pkgs.dwm.override {
  patches = [
    # for local patch files, replace with relative path to patch file
    #./path/to/local.patch
    # for external patches
    (pkgs.fetchpatch {
      # replace with actual URL
      #url = "https://dwm.suckless.org/patches/alpha/dwm-alpha-20230401-348f655.diff";
      #url = "https://dwm.suckless.org/patches/anybar/dwm-anybar-20200810-bb2e722.diff";
      url = "https://dwm.suckless.org/patches/autostart/dwm-autostart-20161205-bb3bd6f.diff";

      # replace hash with the value from `nix-prefetch-url "https://dwm.suckless.org/patches/path/to/patch.diff" | xargs nix hash to-sri --type sha256`
      # or just leave it blank, rebuild, and use the hash value from the error
      hash = "sha256-CQk8fZsicZ6jaLXmxLliNSLHopQVz9XtarPhX9d/sFs=";
    })
  ];
};
  
  # Install firefox.
  programs.firefox.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
  st
  #(st.overrideAttrs (oldAttrs: rec {
   # patches = [
      # You can specify local patches
      #./path/to/local.diff
      # Fetch them directly from `st.suckless.org`
    #  (fetchpatch {
     #   url = "https://st.suckless.org/patches/alpha/st-alpha-0.5.diff";
      #  sha256 = "sha256-xU8FUamzJMgUT7GGkUFhan0LvdXUgT68KJLf68JJROo=";
     # })
   # ];
 # }))

  #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  #  wget
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  #system.stateVersion = "23.11"; # Did you read the comment?
  system.stateVersion = "nixos-unstable"; 

}
