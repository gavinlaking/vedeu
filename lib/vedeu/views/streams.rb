# frozen_string_literal: true

module Vedeu

  module Views

    # A collection of {Vedeu::Views::Stream} instances.
    #
    # @api private
    #
    class Streams < Vedeu::Repositories::Collection

      class << self

        include Vedeu::Common

        # @param (see Vedeu::Repositories::Collection#initialize)
        # @macro raise_invalid_syntax
        # @return [Vedeu::Views::Streams]
        def coerce(collection = [], parent = nil, name = nil)
          if collection.is_a?(Vedeu::Views::Streams)
            collection

          elsif array?(collection)
            return new(collection, parent, name) if collection.empty?

            coerced_collection = []
            collection.each do |element|
              if element.is_a?(Vedeu::Views::Stream)
                coerced_collection << element

              elsif string?(element)
                coerced_collection << Vedeu::Views::Stream.new(value: element)

              end
            end

            new(coerced_collection, parent, name)

          elsif collection.is_a?(Vedeu::Views::Stream)
            new([collection], parent, name)

          elsif collection.is_a?(Vedeu::Views::Chars)
            return new([], parent, name) if collection.empty?

            new([Vedeu::Views::Stream.new(value: collection)], parent, name)

          elsif string?(collection)
            return new([], parent, name) if collection.empty?

            new([Vedeu::Views::Stream.new(value: collection)], parent, name)

          else
            raise Vedeu::Error::InvalidSyntax,
                  'Cannot coerce for Vedeu::View::Streams, as collection ' \
                  "unrecognised. (#{collection.class.name})"

          end
        end

      end # Eigenclass

      alias streams value

    end # Streams

  end # Views

end # Vedeu
