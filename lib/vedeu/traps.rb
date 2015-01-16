module Vedeu

  # Vedeu can respond to various signals which are handled here.
  module Traps

    trap('SIGWINCH') { Vedeu.trigger(:_resize_) }

  end # Traps

end # Vedeu
