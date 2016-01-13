# frozen_string_literal: true

module Vedeu

  module Views

    # A collection of {Vedeu::Cells::Char} instances.
    #
    # @api private
    #
    class Chars < Vedeu::Repositories::Collection

      # @param collection [void]
      # @param parent [Vedeu::Views::Stream]
      # @param name [NilClass|Symbol|String]
      # @macro raise_invalid_syntax
      # @return [Vedeu::Views::Chars]
      def self.coerce(collection = [], parent = nil, name = nil)
        if collection.is_a?(Vedeu::Views::Chars)
          collection

        elsif collection.is_a?(Array)
          return new(collection, parent, name) if collection.empty?

          coerced_collection = []
          collection.each do |element|
            coerced_collection << element if element.is_a?(Vedeu::Cells::Char)
          end

          new(coerced_collection, parent, name)

        elsif collection.is_a?(Vedeu::Views::Stream)
          Vedeu::Views::Chars.coerce(collection.value,
                                     collection.parent,
                                     collection.name)

        elsif collection.is_a?(String)
          return new([], parent, name) if collection.empty?

          if parent && parent.attributes
            new_collection = Vedeu::DSL::Text.new(collection,
                                                  parent.attributes).chars

            new(new_collection, parent, name)
          end

        else
          fail Vedeu::Error::InvalidSyntax,
               'Cannot coerce for Vedeu::View::Chars, as collection is ' \
               'unrecognised.'

        end
      end

      alias_method :chars, :value

    end # Chars

  end # Views

end # Vedeu
