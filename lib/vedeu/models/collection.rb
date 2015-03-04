module Vedeu

  module Model

    # Convert an Array into an object which has some meaning in the context it
    # is being used.
    #
    class Collection

      include Enumerable

      attr_accessor :parent, :name

      # @param collection [Array|Vedeu::Model::Collection]
      # @param parent []
      # @param name [String|NilClass]
      # @return [Vedeu::Model::Collection]
      def self.coerce(collection = [], parent = nil, name = nil)
        if collection.kind_of?(Vedeu::Model::Collection)
          collection

        else
          new(Array(collection), parent, name)

        end
      end

      # @param collection []
      # @param parent []
      # @param name []
      # @return [Vedeu::Model::Collection]
      def initialize(collection = [], parent = nil, name = nil)
        @collection = collection
        @parent     = parent
        @name       = name
      end

      # @param value [Fixnum]
      # @return [void]
      def [](value)
        @collection[value]
      end

      # @param other [Vedeu::Model::Collection]
      # @return [Vedeu::Model::Collection]
      def add(*other)
        self.class.new(@collection += other, parent, name)
      end
      alias_method :<<, :add

      # @return [Array]
      def all
        @collection
      end

      # @param block [Proc]
      # @return [Enumerator]
      def each(&block)
        @collection.each(&block)
      end

      # @return [Boolean]
      def empty?
        @collection.empty?
      end

      # @return [Fixnum]
      def size
        @collection.size
      end

      # @return [String]
      def to_s
        @collection.map(&:to_s).join
      end

    end # Collection

  end # Model

end # Vedeu
