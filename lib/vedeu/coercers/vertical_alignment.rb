# frozen_string_literal: true

module Vedeu

  module Coercers

    # Provides the mechanism to validate a vertical alignment value.
    #
    # @api private
    #
    class VerticalAlignment < Vedeu::Coercers::Alignment

      # @macro raise_invalid_syntax
      # @return (see Vedeu::Coercers::Alignment#validate)
      def validate
        return coerce if valid_vertical?

        fail Vedeu::Error::InvalidSyntax,
             'Missing or invalid vertical alignment value. ' \
             "Valid values are: #{to_sentence}"
      end

      private

      # @return [String]
      def to_sentence
        Vedeu::Sentence.construct(vertical_values)
      end

    end # VerticalAlignment

  end # Coercers

end # Vedeu
