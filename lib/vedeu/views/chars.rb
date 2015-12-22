module Vedeu

  module Views

    # A collection of {Vedeu::Views::Char} instances.
    #
    # @api private
    #
    class Chars < Vedeu::Repositories::Collection

      # @param collection [void]
      # @param parent [Vedeu::Views::Stream]
      # @param name [NilClass|Symbol|String]
      # @raise [Vedeu::Error::InvalidSyntax] When the collection
      #   cannot be coerced since it is unrecognised or unsupported.
      # @return [Vedeu::Views::Chars]
      def self.coerce(collection = [], parent = nil, name = nil)
        if collection.is_a?(Vedeu::Views::Chars)
          collection

        elsif collection.is_a?(Array)
          return new(collection, parent, name) if collection.empty?

          coerced_collection = []
          collection.each do |element|
            coerced_collection << element if element.is_a?(Vedeu::Views::Char)
          end

          new(coerced_collection, parent, name)

        elsif collection.is_a?(Vedeu::Views::Stream)

        elsif collection.is_a?(String)
          return new([], parent, name) if collection.empty?

          if parent && parent.attributes
            new_collection = Vedeu::DSL::Text.new(collection,
                                                  parent.attributes).chars

            new(new_collection, parent, name)
          end

        else
          fail Vedeu::Error::InvalidSyntax,
               'Cannot coerce for Vedeu::View::Streams, as collection ' \
               'unrecognised.'.freeze

        end
      end

      alias_method :chars, :value

    end # Chars

  end # Views

end # Vedeu
