# frozen_string_literal: true

module Vedeu

  module Cells

    # Presents a {Vedeu::Cells} member class as a HTML string.
    #
    # @api private
    #
    class HTML

      include Vedeu::Common

      # @param cell [void] The {Vedeu::Cells} class to be presented as
      #   HTML.
      # @param options [Hash] Options provided by
      #   {Vedeu::Renderers::HTML}.
      # @return [Vedeu::Cells::HTML]
      def initialize(cell, options = {})
        @cell    = cell
        @options = options || {}
      end

      # @return [String]
      def to_html
        "#{start_tag}#{style_attribute}>#{value}#{end_tag}"
      end

      protected

      # @!attribute [r] cell
      # @return [void]
      attr_reader :cell

      # @!attribute [r] options
      # @return [Hash]
      attr_reader :options

      private

      # @return [String]
      def background
        return '' unless cell.respond_to?(:background)

        cell.background.to_html
      end

      # @return [String]
      def end_tag
        options.fetch(:end_tag, '</td>')
      end

      # @return [String]
      def foreground
        return '' unless cell.respond_to?(:foreground)

        cell.foreground.to_html
      end

      # @return [String]
      def start_tag
        options.fetch(:start_tag, '<td')
      end

      # @return [String]
      def style_attribute
        return '' if absent?(background) && absent?(foreground)

        " style='#{background}#{foreground}'"
      end

      # @return [String]
      def value
        if cell.respond_to?(:as_html) && present?(cell.as_html)
          cell.as_html

        else
          '&nbsp;'

        end
      end

    end # HTML

  end # Cells

end # Vedeu
