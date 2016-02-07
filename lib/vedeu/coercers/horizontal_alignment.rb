# frozen_string_literal: true

module Vedeu

  module Coercers

    # Provides the mechanism to validate a horizontal alignment value.
    #
    # @api private
    #
    class HorizontalAlignment < Vedeu::Coercers::Alignment

      # @macro raise_invalid_syntax
      # @return (see Vedeu::Coercers::Alignment#validate)
      def validate
        return coerce if valid_horizontal?

        raise Vedeu::Error::InvalidSyntax,
              'Missing or invalid horizontal alignment value. ' \
              "Valid values are: #{to_sentence}"
      end

      private

      # @return [String]
      def to_sentence
        Vedeu::Sentence.construct(horizontal_values)
      end

    end # HorizontalAlignment

  end # Coercers

end # Vedeu
