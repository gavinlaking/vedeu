module Vedeu

  # Vedeu can respond to various signals which are handled here.
  #
  module Traps

    Signal.trap('INT') { exit! }

    Signal.trap('TERM') { exit! }

    Signal.trap('TTIN') {}
    Signal.trap('USR1') {}
    Signal.trap('USR2') {}

    Signal.trap('SIGWINCH') { Vedeu.trigger(:_resize_) }

  end # Traps

end # Vedeu
