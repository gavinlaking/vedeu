module Vedeu

  # Vedeu can respond to various signals which are handled here.
  #
  module Traps

    Signal.trap('INT') { exit! }

    Signal.trap('TERM') { exit! }

    #TTIN
    #USR1
    #USR2

    Signal.trap('SIGWINCH') { Vedeu.trigger(:_resize_) }

  end # Traps

end # Vedeu
