module Vedeu

  module Views

    # A collection of {Vedeu::Views::Stream} instances.
    #
    # @api private
    #
    class Streams < Vedeu::Repositories::Collection

      # @param (see Vedeu::Repositories::Collection#initialize)
      # @raise [Vedeu::Error::InvalidSyntax] When the collection
      #   cannot be coerced since it is unrecognised or unsupported.
      # @return [Vedeu::Views::Streams]
      def self.coerce(collection = [], parent = nil, name = nil)
        if collection.is_a?(Vedeu::Views::Streams)
          collection

        elsif collection.is_a?(Array)
          return new(collection, parent, name) if collection.empty?

          coerced_collection = []
          collection.each do |element|
            if element.is_a?(Vedeu::Views::Stream)
              coerced_collection << element

            elsif element.is_a?(String)
              coerced_collection << Vedeu::Views::Stream.new(value: element)

            end
          end

          new(coerced_collection, parent, name)

        elsif collection.is_a?(Vedeu::Views::Stream)
          new([collection], parent, name)

        elsif collection.is_a?(String)
          return new([], parent, name) if collection.empty?

          new([Vedeu::Views::Stream.new(value: collection)], parent, name)

        else
          fail Vedeu::Error::InvalidSyntax,
               'Cannot coerce for Vedeu::View::Streams, as collection ' \
               'unrecognised.'.freeze

        end
      end

    end # Streams

  end # Views

end # Vedeu
