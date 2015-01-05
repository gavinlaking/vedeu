module Vedeu

  module Model

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
        Collection.new(@collection += other, parent, name)
      end
      alias_method :<<, :add

      def all
        @collection
      end

      def each(&block)
        @collection.each do |element|
          if block_given?
            block.call(element)

          else
            yield element

          end
        end
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

    Interfaces = Class.new(Collection)
    Lines      = Class.new(Collection)
    Streams    = Class.new(Collection)
    Chars      = Class.new(Collection)

  end # Model

end # Vedeu
