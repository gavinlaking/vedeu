module Vedeu

  # Vedeu can respond to various signals which are handled here.
  #
  # @api private
  module Traps

    Signal.trap('INT') { puts; exit(1) }

    Signal.trap('TERM') { puts; exit(1) }

    Signal.trap('TTIN') {}
    Signal.trap('USR1') {}
    Signal.trap('USR2') {}

    Signal.trap('SIGWINCH') { Vedeu.trigger(:_resize_) }

  end # Traps

end # Vedeu
