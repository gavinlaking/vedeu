# frozen_string_literal: true

module Vedeu

  module Buffers

    # Refreshes only the content of the given named interface.
    #
    class RefreshContent

      include Vedeu::Common

      # {include:file:docs/events/by_name/refresh_view_content.md}
      # @param (see #initialize)
      # @return (see #by_name)
      def self.by_name(name = Vedeu.focus)
        new(name).by_name
      end

      # Return a new instance of Vedeu::Buffers::RefreshContent.
      #
      # @macro param_name
      # @return [Vedeu::Buffers::RefreshContent]
      def initialize(name = Vedeu.focus)
        @name = name || Vedeu.focus
      end

      # @return [Array|Vedeu::Error::ModelNotFound]
      def by_name
        Vedeu.clear_content_by_name(name)

        buffer.render
      end

      protected

      # @!attribute [r] name
      # @macro return_name
      attr_reader :name

      private

      # @return [Vedeu::Buffers::Buffer]
      def buffer
        Vedeu.buffers.by_name(name)
      end

    end # RefreshContent

  end # Buffers

end # Vedeu
