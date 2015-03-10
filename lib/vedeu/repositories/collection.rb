module Vedeu

  # Convert an Array into an object which has some meaning in the context it
  # is being used.
  #
  class Collection

    include Enumerable

    # @!attribute [rw] parent
    # @return [Fixnum]
    attr_accessor :parent

    # @!attribute [rw] name
    # @return [String]
    attr_accessor :name

    # @param collection [Array|Vedeu::Collection]
    # @param parent [void]
    # @param name [String|NilClass]
    # @return [Vedeu::Collection]
    def self.coerce(collection = [], parent = nil, name = nil)
      if collection.kind_of?(Vedeu::Collection)
        collection

      else
        new(Array(collection), parent, name)

      end
    end

    # @param collection []
    # @param parent [void]
    # @param name [String|NilClass]
    # @return [Vedeu::Collection]
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

    # @param other [Vedeu::Collection]
    # @return [Vedeu::Collection]
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

end # Vedeu
