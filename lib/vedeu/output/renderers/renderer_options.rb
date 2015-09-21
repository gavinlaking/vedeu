module Vedeu

  module Renderers

    # Provides shared functionality to Vedeu::Renderer classes.
    #
    # :nocov:
    module RendererOptions

      private

      # Combines the options provided at instantiation with the
      # default values.
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

    end # RendererOptions
    # :nocov:

  end # Renderers

end # Vedeu
