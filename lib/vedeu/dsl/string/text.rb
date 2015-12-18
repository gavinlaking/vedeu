module Vedeu

  module DSL

    # Manipulates text values based on given options when building
    # views.
    #
    # @api private
    #
    class Text

      include Vedeu::Common

      # @param value [String]
      # @param options [Vedeu::DSL::ViewOptions]
      # @return [Vedeu::DSL::Text]
      def initialize(value = '', options = {})
        @value   = value   || ''
        @options = options || {}
      end

      # @return [Array<Vedeu::Views::Char>]
      def chars
        return [] unless present?(value) && string?(value)

        collection
      end

      protected

      # @!attribute [r] options
      # @return [Hash<Symbol => void>]
      attr_reader :options

      # @!attribute [r] value
      # @return [NilClass|String]
      attr_reader :value

      private

      # @return [String]
      def align
        Vedeu::DSL::Align.new(value, options).text
      end

      def align?
        options[:align] &&
        [:center, :centre, :left, :right].include?(options[:align])
      end

      # @param char [String]
      # @return [Hash<Symbol => void>]
      def attributes(char)
        {
          colour:   options[:colour],
          name:     name,
          parent:   parent,
          position: nil,
          style:    options[:style],
          value:    char,
        }
      end

      # @return [Array<Vedeu::Views::Char>]
      def collection
        text.chars.map { |char| Vedeu::Views::Char.new(attributes(char)) }
      end

      # @return [NilClass|String|Symbol]
      def name
        options[:name]
      end

      # @return [NilClass|void]
      def parent
        options[:parent]
      end

      # @return [String]
      def text
        if truncate?
          truncate

        elsif align?
          align

        else
          ''

        end
      end

      # @return [String]
      def truncate
        Vedeu::DSL::Truncate.new(value, options).text
      end

      def truncate?
        options[:truncate]
      end

    end # Text

  end # DSL

end # Vedeu
