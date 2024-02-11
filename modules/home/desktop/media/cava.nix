{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.modules.desktop.media;
in
  with lib; {
    config = mkIf cfg.enable {
      home.packages = [pkgs.cava];
      xdg.configFile."cava/config".text = with config.colorScheme.palette; ''
          [output]

        # Output method. Can be 'ncurses', 'noncurses', 'raw', 'noritake' or 'sdl'.
        # 'noncurses' uses a custom framebuffer technique and prints only changes
        # from frame to frame in the terminal. 'ncurses' is default if supported.
        #
        # 'raw' is an 8 or 16 bit (configurable via the 'bit_format' option) data
        # stream of the bar heights that can be used to send to other applications.
        # 'raw' defaults to 200 bars, which can be adjusted in the 'bars' option above.
        #
        # 'noritake' outputs a bitmap in the format expected by a Noritake VFD display
        #  in graphic mode. It only support the 3000 series graphical VFDs for now.
        #
        # 'sdl' uses the Simple DirectMedia Layer to render in a graphical context.
        ; method = ncurses

        # Visual channels. Can be 'stereo' or 'mono'.
        # 'stereo' mirrors both channels with low frequencies in center.
        # 'mono' outputs left to right lowest to highest frequencies.
        # 'mono_option' set mono to either take input from 'left', 'right' or 'average'.
        # set 'reverse' to 1 to display frequencies the other way around.
        channels = stereo
        ; mono_option = average
        ; reverse = 0

        # Raw output target. A fifo will be created if target does not exist.
        ; raw_target = /dev/stdout

        # Raw data format. Can be 'binary' or 'ascii'.
        ; data_format = binary

        # Binary bit format, can be '8bit' (0-255) or '16bit' (0-65530).
        ; bit_format = 16bit

        # Ascii max value. In 'ascii' mode range will run from 0 to value specified here
        ; ascii_max_range = 1000

        # Ascii delimiters. In ascii format each bar and frame is separated by a delimiters.
        # Use decimal value in ascii table (i.e. 59 = ';' and 10 = '\n' (line feed)).
        ; bar_delimiter = 59
        ; frame_delimiter = 10

        # sdl window size and position. -1,-1 is centered.
        ; sdl_width = 1000
        ; sdl_height = 500
        ; sdl_x = -1
        ; sdl_y= -1

        # set label on bars on the x-axis. Can be 'frequency' or 'none'. Default: 'none'
        # 'frequency' displays the lower cut off frequency of the bar above.
        # Only supported on ncurses and noncurses output.
        ; xaxis = none

        # enable alacritty synchronized updates. 1 = on, 0 = off
        # removes flickering in alacritty terminal emeulator.
        # defaults to off since the behaviour in other terminal emulators is unknown
        ; alacritty_sync = 0

        [color]
        ; background = default
        ; foreground = default

        # SDL only support hex code  these are the default:
        ; background = '#111111'
        ; foreground = '#33cccc'


        # Gradient mode, only hex defined (and thereby ncurses mode) are supported,
        # background must also be defined in hex  or remain commented out. 1 = on, 0 = off.
        # You can define as many as 8 different  They range from bottom to top of screen
        gradient = 1
        gradient_count = 3
        gradient_color_1 = '#${base0D}'
        gradient_color_2 = '#${base0C}'
        gradient_color_3 = '#${base0D}'


        [smoothing]

        # Percentage value for integral smoothing. Takes values from 0 - 100.
        # Higher values means smoother, but less precise. 0 to disable.
        # DEPRECATED as of 0.8.0, use noise_reduction instead
        ; integral = 77

        # Disables or enables the so-called "Monstercat smoothing" with or without "waves". Set to 0 to disable.
        ; monstercat = 0
        ; waves = 0

        # Set gravity percentage for "drop off". Higher values means bars will drop faster.
        # Accepts only non-negative values. 50 means half gravity, 200 means double. Set to 0 to disable "drop off".
        # DEPRECATED as of 0.8.0, use noise_reduction instead
        ; gravity = 100


        # In bar height, bars that would have been lower that this will not be drawn.
        # DEPRECATED as of 0.8.0
        ; ignore = 0

        # Noise reduction, float 0 - 1. default 0.77
        # the raw visualization is very noisy, this factor adjusts the integral and gravity filters to keep the signal smooth
        # 1 will be very slow and smooth, 0 will be fast but noisy.
        ; noise_reduction = 0.77


        [eq]

        # This one is tricky. You can have as much keys as you want.
        # Remember to uncomment more then one key! More keys = more precision.
        # Look at readme.md on github for further explanations and examples.
        ; 1 = 1 # bass
        ; 2 = 1
        ; 3 = 1 # midtone
        ; 4 = 1
        ; 5 = 1 # treble
      '';
    };
  }
