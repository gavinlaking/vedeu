module Vedeu

  module Model

    class Collection

      include Enumerable

      attr_accessor :parent

      # def self.coerce(parent = nil, collection = [])
      #   new(parent, collection).coerce
      # end

      def initialize(parent = nil, collection = [])
        @parent     = parent
        @collection = collection
      end

      def add(*other)
        Collection.new(parent, @collection += other)
      end

      def all
        @collection
      end

      # def coerce
      #   return self if empty?
      #   return collection if collection.kind_of?(Collection)

      #   collection.each do |model|
      #     add(model)
      #   end
      # end

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

  end # Model

end # Vedeu
