# frozen_string_literal: true

module Vedeu

  module Buffers

    # Refreshes the given named interface.
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
      # @param name [String|Symbol] The name of the interface/view to
      #   be refreshed. Defaults to `Vedeu.focus`.
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

      # @return [Vedeu::Buffers::Buffer]
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

      # @return [Hash<Symbol => Boolean>]
      def defaults
        {
          content_only: false,
        }
      end

    end # Refresh

  end # Buffers

  # :nocov:

  # See {file:docs/events/by_name/refresh_view.md}
  Vedeu.bind(:_refresh_view_) do |name|
    Vedeu::Buffers::Refresh.by_name(name) if Vedeu.ready?
  end

  # See {file:docs/events/by_name/refresh_view_content.md}
  Vedeu.bind(:_refresh_view_content_) do |name|
    Vedeu::Buffers::Refresh.refresh_content_by_name(name) if Vedeu.ready?
  end

  # :nocov:

end # Vedeu
