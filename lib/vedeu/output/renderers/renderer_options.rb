module Vedeu

  # Provides shared functionality to Vedeu::Renderer classes.
  #
  module RendererOptions

    # :nocov:

    private

    # Combines the options provided at instantiation with the default values.
    #
    # @return [Hash<Symbol => void>]
    def options
      defaults.merge!(@options)
    end

    # The default values for a new instance of this class.
    #
    # @return [Hash<Symbol => void>]
    def defaults
      {}
    end

    # :nocov:

  end # RendererOptions

end # Vedeu
