module Vedeu

  # Translates escape sequences provided by the terminal into symbols which
  # Vedeu can use for various behaviours.
  #
  class InputTranslator

    # @param code [String]
    # @return [Symbol]
    def self.translate(code)
      new(code).translate
    end

    # Returns a new instance of Vedeu::InputTranslator.
    #
    # @param code [String]
    # @return [Vedeu::InputTranslator]
    def initialize(code)
      @code = code
    end

    # @return [Symbol]
    def translate
      symbols.fetch(code, code)
    end

    protected

    # @!attribute [r] code
    # @return [String]
    attr_reader :code

    private

    # @return [Hash<String => Symbol>]
    def symbols
      @symbols ||= f_keys.merge!(ctrl_letters).merge!(specials)
    end

    # @return [Hash<String => Symbol>]
    def ctrl_letters
      {
        "\u0001"  => :ctrl_a,
        "\u0002"  => :ctrl_b,
        "\u0003"  => :ctrl_c,
        "\u2404"  => :ctrl_c,
        "\u0004"  => :ctrl_d,
        "\u2403"  => :ctrl_d,
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
        "\u2412"  => :ctrl_r,
        "\u0019"  => :ctrl_s,
        # "\u0020"  => :ctrl_t, # duplicates spacebar
        "\u0021"  => :ctrl_u,
        "\u0022"  => :ctrl_v,
        "\u0023"  => :ctrl_w,
        "\u0024"  => :ctrl_x,
        "\u0025"  => :ctrl_y,
        "\u0026"  => :ctrl_z,
      }
    end

    # @return [Hash<String => Symbol>]
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

    # @return [Hash<String => Symbol>]
    def specials
      {
        "\u007F"  => :backspace,
        "\u2408"  => :backspace,
        "\u23CE"  => :carriage_return,
        "\e[3~"   => :delete,
        "\u232B"  => :delete,
        "\e[B"    => :down,
        "\u2193"  => :down,
        "\e[F"    => :end,
        "\r"      => :enter,
        "\n"      => :enter,
        "\e"      => :escape,
        "\u238B"  => :escape,
        "\e[H"    => :home,
        "\eOH"    => :home,
        "\e[2~"   => :insert,
        "\e[D"    => :left,
        "\u2190"  => :left,
        "\u240A"  => :line_feed,
        "\e[5~"   => :page_up,
        "\e[6~"   => :page_down,
        "\e[1;2R" => :pause_break,
        "\e[1;2P" => :print_screen,
        "\e[C"    => :right,
        "\u2192"  => :right,
        "\e[1;2Q" => :scroll_lock,
        "\e[Z"    => :shift_tab,
        "\t"      => :tab,
        "\u21B9"  => :tab,
        "\e[A"    => :up,
        "\u2191"  => :up,
      }
    end

  end # InputTranslator

end # Vedeu
