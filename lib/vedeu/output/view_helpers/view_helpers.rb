module Vedeu

  # This module can be included client application classes to provide various
  # further functionality and simplify Vedeu view construction.
  #
  # @api public
  module ViewHelpers

    # Returns the current local time.
    #
    # @example
    #   time_now # => Mon 29 Jun 19:26
    #
    # @return [String]
    def time_now
      Time.now.strftime('%a %e %b %k:%M')
    end

  end # ViewHelpers

end # Vedeu
