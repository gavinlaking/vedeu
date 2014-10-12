module Vedeu

  # Captures input from the user via {Vedeu::Terminal#input} and translates
  # special characters into symbols.
  #
  # @api private
  class Input

    # @return [String|Symbol]
    def self.capture
      new.capture
    end

    # Returns a new instance of Input.
    #
    # @return [Input]
    def initialize; end

    # @return []
    def capture
      Vedeu.trigger(:_keypress_, keypress)
    end

    private

    # @return [String]
    def input
      @_input ||= Terminal.input
    end

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
        "\eOP"    => :f1,
        "\eOQ"    => :f2,
        "\eOR"    => :f3,
        "\eOS"    => :f4,
        "\e[15~"  => :f5,
        "\e[17~"  => :f6,
        "\e[18~"  => :f7,
        "\e[19~"  => :f8,
        "\e[20~"  => :f9,
        "\e[21~"  => :f10,
        "\e[23~"  => :f11,
        "\e[24~"  => :f12,
        "\e[1;2P" => :print_screen,
        "\e[1;2Q" => :scroll_lock,
        "\e[1;2R" => :pause_break,
        "\u007F"  => :backspace,
      }
    end

  end # Input

end # Vedeu
