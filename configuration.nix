# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ inputs, config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "dan"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

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
  # You can disable this if you're only using the Wayland session.
  services.xserver.enable = true;

  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
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
  users.users.dan = {
    isNormalUser = true;
    description = "Dan";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      kdePackages.kate
    #  thunderbird
    ];
  };

  # Install firefox.
  programs.firefox.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
  #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  #  wget
    pciutils
  ];

  #Enables flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  hardware.bluetooth.enable = true; # enables support for Bluetooth
  hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot

  virtualisation.docker.enable = true;
  users.users.dan.extraGroups = [ "docker" ];
  virtualisation.docker.rootless = {
    enable = true;
    setSocketVariable = true;
  };
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  services.power-profiles-daemon.enable = true; #plasma thing
  powerManagement.cpuFreqGovernor = "powersave";
  services.tlp = {
      enable = false;
      settings = {
        #Audio config (disables TLP audio)
        SOUND_POWER_SAVE_ON_AC = "0";
        SOUND_POWER_SAVE_ON_BAT = "0";
        SOUND_POWER_SAVE_CONTROLLER = "N";

        #Battery config
        START_CHARGE_THRESH_BAT0 = "70";
        STOP_CHARGE_THRESH_BAT0 = "80";

        #Drive Bay (none)

        #Disks and Controllers (Prob not needed, look into)

        #Disk setting (none)

        #Graphics (no invidia options)

        #Kernel (none, only does NMI callback stuff)

        #Wifi Power management
        WIFI_PWR_ON_AC="off";
        WIFI_PWR_ON_BAT="off";
        WOL_DISABLE="Y"; #wake on lan disable

        #Platform bat
        PLATFORM_PROFILE_ON_AC="performance";
        PLATFORM_PROFILE_ON_BAT="balanced";
        #MEM_SLEEP_ON_AC=s2idle #idk what does
        #MEM_SLEEP_ON_BAT=deep

        #CPU (complex, do later)

        #Radio devices (wifi)
        RESTORE_DEVICE_STATE_ON_STARTUP = "1"; #keeps on        

        #PCI stuff
        #RUNTIME_PM_DISABLE = "";

        #USB settings
        USB_AUTOSUSPEND = "0";

        #Recomended CPU config
        #CPU_SCALING_GOVERNOR_ON_AC = "performance";
        #CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

        #CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
        #CPU_ENERGY_PERF_POLICY_ON_AC = "performance";

        #CPU_MIN_PERF_ON_AC = 0;
        #CPU_MAX_PERF_ON_AC = 100;
        #CPU_MIN_PERF_ON_BAT = 0;
        #CPU_MAX_PERF_ON_BAT = 20;

       #Optional helps save long term battery health
       #START_CHARGE_THRESH_BAT0 = 40; # 40 and bellow it starts to charge
       #STOP_CHARGE_THRESH_BAT0 = 80; # 80 and above it stops charging

      };
    };

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
  system.stateVersion = "24.11"; # Did you read the comment?

}
