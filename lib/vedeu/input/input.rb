module Vedeu

  # Captures input from the user via {Vedeu::Terminal#input} and translates
  # special characters into symbols.
  #
  # @api private
  class Input

    # Instantiate Input and capture keypress(es).
    #
    # @param (see #initialize)
    # @return [String|Symbol]
    def self.capture(reader)
      new(reader).capture
    end

    # Returns a new instance of Vedeu::Input.
    #
    # @param reader [IO] An object that responds to `#read`. Typically, this is
    #   Vedeu::Terminal.
    # @return [Input]
    def initialize(reader)
      @reader = reader
    end

    # Triggers either a ':_command_' event with the command if the reader is in
    # cooked mode, or if raw mode, the keypress event with the key(s) pressed.
    #
    # @return [Array|String|Symbol]
    def capture
      if reader.raw_mode?
        Vedeu.trigger(:_keypress_, keypress)

      else
        Vedeu.trigger(:_command_, command)

      end
    end

    protected

    # @!attribute [r] reader
    # @return [IO]
    attr_reader :reader

    private

    # Returns the input from the terminal.
    #
    # @return [String]
    def input
      @input ||= reader.read
    end
    alias_method :command, :input

    # Returns the translated (if possible) keypress(es) as either a String or a
    # Symbol.
    #
    # @return [String|Symbol]
    def keypress
      key = input

      specials.fetch(key, key)
    end

    # Translates (if possible) entered escape sequences into symbols
    # representing the key which was pressed.
    #
    # @return [Hash]
    def specials
      {
        "\r"      => :enter,
        "\n"      => :enter,
        "\t"      => :tab,
        "\e"      => :escape,
        "\e[A"    => :up,
        "\e[B"    => :down,
        "\e[C"    => :right,
        "\e[D"    => :left,
        "\e[5~"   => :page_up,
        "\e[6~"   => :page_down,
        "\e[H"    => :home,
        "\e[3~"   => :delete,
        "\e[F"    => :end,
        "\e[Z"    => :shift_tab,
        "\e[1;2P" => :print_screen,
        "\e[1;2Q" => :scroll_lock,
        "\e[1;2R" => :pause_break,
        "\u007F"  => :backspace,
        "\u0001"  => :ctrl_a,
        "\u0002"  => :ctrl_b,
        "\u0003"  => :ctrl_c,
        "\u0004"  => :ctrl_d,
        "\u0005"  => :ctrl_e,
        "\u0006"  => :ctrl_f,
        "\u0007"  => :ctrl_g,
        "\u0008"  => :ctrl_h,
        # "\u0009"  => :ctrl_i, # duplicates tab
        "\u0010"  => :ctrl_j, # produces "\n"
        "\u0011"  => :ctrl_k,
        "\u0012"  => :ctrl_l,
        "\u0013"  => :ctrl_m,
        "\u0014"  => :ctrl_n,
        "\u0015"  => :ctrl_o,
        "\u0016"  => :ctrl_p,
        "\u0017"  => :ctrl_q,
        "\u0018"  => :ctrl_r,
        "\u0019"  => :ctrl_s,
        # "\u0020"  => :ctrl_t, # duplicates spacebar
        "\u0021"  => :ctrl_u,
        "\u0022"  => :ctrl_v,
        "\u0023"  => :ctrl_w,
        "\u0024"  => :ctrl_x,
        "\u0025"  => :ctrl_y,
        "\u0026"  => :ctrl_z,
      }.merge(f_keys)
    end

    # @return [Hash<String => Symbol]
    def f_keys
      {
        "\eOP"      => :f1,
        "\eOQ"      => :f2,
        "\eOR"      => :f3,
        "\eOS"      => :f4,
        "\e[15~"    => :f5,
        "\e[15;2~"  => :shift_f5,
        "\e[15;5~"  => :ctrl_f5,
        "\e[17~"    => :f6,
        "\e[17;2~"  => :shift_f6,
        "\e[17;5~"  => :ctrl_f6,
        "\e[18~"    => :f7,
        "\e[18;2~"  => :shift_f7,
        "\e[18;5~"  => :ctrl_f7,
        "\e[19~"    => :f8,
        "\e[19;2~"  => :shift_f8,
        "\e[19;5~"  => :ctrl_f8,
        "\e[20~"    => :f9,
        "\e[20;2~"  => :shift_f9,
        "\e[20;5~"  => :ctrl_f9,
        "\e[21~"    => :f10,
        "\e[21;2~"  => :shift_f10,
        "\e[21;5~"  => :ctrl_f10,
        "\e[23~"    => :f11,
        "\e[23;2~"  => :shift_f11,
        "\e[23;5~"  => :ctrl_f11,
        "\e[24~"    => :f12,
        "\e[24;2~"  => :shift_f12,
        "\e[24;5~"  => :ctrl_f12,
      }
    end

  end # Input

end # Vedeu
