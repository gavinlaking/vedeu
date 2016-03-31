# frozen_string_literal: true

module Vedeu

  module Runtime

    # Vedeu can respond to various signals which are handled here.
    #
    # @api private
    #
    module Traps

      # :nocov:

      # @param keys [Array<Symbol>]
      # @macro param_block
      # @macro raise_requires_block
      # @return [Array<Symbol>]
      def self.add_signal_trap(*keys, &block)
        raise Vedeu::Error::RequiresBlock unless block_given?

        # fail Signal.list.inspect

        keys.each do |key|
          Signal.trap(key.to_s, &block) if Signal.list.key?(key.to_s)
        end
      end

      # Resize terminal
      add_signal_trap(:WINCH) { Vedeu.trigger(:_resize_) }

      # Stop runtime (failure)
      add_signal_trap(:INT, :TERM) { exit(1) }

      # Read from terminal
      add_signal_trap(:TTIN) {}

      # User
      add_signal_trap(:USR1, :USR2) {}

      # Signals from Ubuntu Linux 16.04.
      #
      # {
      #   "EXIT"   => 0,
      #   "HUP"    => 1,
      #   "INT"    => 2,
      #   "QUIT"   => 3,
      #   "ILL"    => 4,
      #   "TRAP"   => 5,
      #   "ABRT"   => 6,
      #   "IOT"    => 6,
      #   "BUS"    => 7,
      #   "FPE"    => 8,
      #   "KILL"   => 9,
      #   "USR1"   => 10,
      #   "SEGV"   => 11,
      #   "USR2"   => 12,
      #   "PIPE"   => 13,
      #   "ALRM"   => 14,
      #   "TERM"   => 15,
      #   "CHLD"   => 17,
      #   "CLD"    => 17,
      #   "STOP"   => 19,
      #   "CONT"   => 18,
      #   "TSTP"   => 20,
      #   "TTIN"   => 21,
      #   "TTOU"   => 22,
      #   "URG"    => 23,
      #   "XCPU"   => 24,
      #   "XFSZ"   => 25,
      #   "VTALRM" => 26,
      #   "PROF"   => 27,
      #   "WINCH"  => 28,
      #   "IO"     => 29,
      #   "POLL"   => 29,
      #   "PWR"    => 30,
      #   "SYS"    => 31,
      # }

      # :nocov:

    end # Traps

  end # Runtime

end # Vedeu
