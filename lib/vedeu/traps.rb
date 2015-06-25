module Vedeu

  # Vedeu can respond to various signals which are handled here.
  #
  # @api private
  module Traps

    Signal.trap('INT') do
      puts
      exit(1)
    end

    Signal.trap('TERM') do
      puts
      exit(1)
    end

    Signal.trap('TTIN') {}
    Signal.trap('USR1') {}
    Signal.trap('USR2') {}

    Signal.trap('SIGWINCH') { Vedeu.trigger(:_resize_) }

  end # Traps

end # Vedeu
