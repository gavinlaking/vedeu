module Vedeu

  # Provides methods to be used by {Vedeu::ApplicationView}.
  #
  module View

    # Returns the current local time.
    #
    # @example
    #   time_now # => Mon 29 Jun 19:26
    #
    # @return [String]
    def time_now
      Time.now.strftime('%a %e %b %k:%M')
    end

  end # View

end # Vedeu
