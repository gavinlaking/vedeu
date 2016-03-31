# frozen_string_literal: true

module Vedeu

  module Buffers

    # Refreshes the given named interface.
    #
    # @api private
    #
    class Refresh

      include Vedeu::Common

      # {include:file:docs/events/by_name/refresh_view.md}
      # @param (see #initialize)
      # @return (see #by_name)
      def self.by_name(name = Vedeu.focus)
        name ||= Vedeu.focus

        new(name).by_name
      end

      # {include:file:docs/events/by_name/refresh_view_content.md}
      # @param (see #initialize)
      # @return (see #by_name)
      def self.refresh_content_by_name(name = Vedeu.focus)
        name ||= Vedeu.focus

        new(name, content_only: true).by_name
      end

      # Return a new instance of Vedeu::Buffers::Refresh.
      #
      # @macro param_name
      # @param options [Hash<Symbol => Boolean>]
      # @option options content_only [Boolean]
      # @return [Vedeu::Buffers::Refresh]
      def initialize(name, options = {})
        @name    = name
        @options = options
      end

      # @return [Array|Vedeu::Error::ModelNotFound]
      def by_name
        Vedeu.trigger(:_clear_view_content_, name)

        buffer.render

        Vedeu.trigger(:_refresh_border_, name) unless content_only?
      end

      private

      # @macro buffer_by_name
      def buffer
        Vedeu.buffers.by_name(name)
      end

      # @return [Boolean]
      def content_only?
        truthy?(options[:content_only])
      end

      # @return [String|Symbol]
      def name
        present?(@name) ? @name : Vedeu.focus
      end

      # @return [Hash<Symbol => Boolean>]
      def options
        defaults.merge!(@options)
      end

      # @macro defaults_method
      def defaults
        {
          content_only: false,
        }
      end

    end # Refresh

  end # Buffers

end # Vedeu
