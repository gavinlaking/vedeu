module Vedeu

  # Vedeu can respond to various signals which are handled here.
  #
  module Traps

    # :nocov:
    Signal.trap('INT') do
      exit(1)
    end

    Signal.trap('TERM') do
      exit(1)
    end

    Signal.trap('TTIN') {}
    Signal.trap('USR1') {}
    Signal.trap('USR2') {}

    Signal.trap('SIGWINCH') { Vedeu.trigger(:_resize_) }
    # :nocov:

  end # Traps

end # Vedeu
