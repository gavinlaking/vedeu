module Vedeu

  module Buffers

    # Refreshes the given named interface.
    #
    class Refresh

      include Vedeu::Common

      # @example
      #   Vedeu.trigger(:_refresh_view_, name)
      #
      # @param (see #initialize)
      # @return (see #by_name)
      def self.by_name(name)
        new(name).by_name
      end

      # @example
      #   Vedeu.trigger(:_refresh_view_content_, name)
      #
      # @param (see #initialize)
      # @return (see #by_name)
      def self.refresh_content_by_name(name)
        new(name, content_only: true).by_name
      end

      # Return a new instance of Vedeu::Buffers::Refresh.
      #
      # @param name [String|Symbol] The name of the interface to be refreshed
      #   using the named buffer.
      # @param options [Hash]
      # @option options content_only [Boolean]
      # @return [Vedeu::Buffers::Refresh]
      def initialize(name, options = {})
        @name    = name
        @options = options
      end

      # @return [Array|Vedeu::Error::ModelNotFound]
      def by_name
        if Vedeu.ready?
          Vedeu.trigger(:_clear_view_content_, name)

          Vedeu.timer("Refresh Buffer: '#{name}'") do
            Vedeu.buffers.by_name(name).render
          end

          Vedeu.trigger(:_refresh_border_, name) unless content_only?
        end
      end

      protected

      # @!attribute [r] name
      # @return [String|Symbol]
      attr_reader :name

      # @return [Boolean]
      def content_only?
        options[:content_only] == true
      end

      # @return [Hash<Symbol => Boolean>]
      def options
        defaults.merge!(@options)
      end

      # @return [Hash<Symbol => Boolean>]
      def defaults
        {
          content_only: false,
        }
      end

    end # Refresh

  end # Buffers

end # Vedeu
