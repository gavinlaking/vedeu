module Vedeu

  module Model

    # Convert an Array into an object which has some meaning in the context it
    # is being used.
    #
    # @private
    class Collection

      include Enumerable

      attr_accessor :parent, :name

      def self.coerce(collection = [], parent = nil, name = nil)
        if collection.kind_of?(Vedeu::Model::Collection)
          collection

        elsif collection.is_a?(Array)
          new(collection, parent, name)

        else
          new(Array(collection), parent, name)

        end
      end

      def initialize(collection = [], parent = nil, name = nil)
        @collection = collection
        @parent     = parent
        @name       = name
      end

      def [](value)
        @collection[value]
      end

      def add(*other)
        self.class.new(@collection += other, parent, name)
      end
      alias_method :<<, :add

      def all
        @collection
      end

      def each(&block)
        @collection.each(&block)
      end

      def empty?
        @collection.empty?
      end

      def size
        @collection.size
      end

      def to_s
        @collection.map(&:to_s).join
      end

    end # Collection

  end # Model

end # Vedeu
