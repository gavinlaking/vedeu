module Vedeu

  # This module can be included client application classes to provide various
  # further functionality and simplify Vedeu view construction.
  #
  module ViewHelpers

    def time_now
      Time.now.strftime("%a %e %b %k:%M")
    end

  end # ViewHelpers

end # Vedeu
