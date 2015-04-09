module Vedeu

  # Convert an Array into an object which has some meaning in the context it
  # is being used.
  #
  class Collection

    include Enumerable

    # @!attribute [r] collection
    # @return [Array|Vedeu::Collection]
    attr_reader :collection
    alias_method :all, :collection

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
      if collection.is_a?(Vedeu::Collection)
        collection

      else
        new(Array(collection), parent, name)

      end
    end

    # Returns a new instance of Vedeu::Collection.
    #
    # @param collection []
    # @param parent [void]
    # @param name [String|NilClass]
    # @return [Vedeu::Collection]
    def initialize(collection = [], parent = nil, name = nil)
      @collection = collection
      @parent     = parent
      @name       = name
    end

    # Fetch an entry from the collection via index.
    #
    # @param value [Fixnum]
    # @return [void]
    def [](value)
      collection[value]
    end

    # Adds an entry to the collection.
    #
    # @param other [Vedeu::Collection]
    # @return [Vedeu::Collection]
    def add(*other)
      self.class.new(@collection += other, parent, name)
    end
    alias_method :<<, :add

    # Provides iteration over the collection.
    #
    # @param block [Proc]
    # @return [Enumerator]
    def each(&block)
      collection.each(&block)
    end

    # Returns a boolean indicating whether the collection is empty.
    #
    # @return [Boolean]
    def empty?
      collection.empty?
    end

    # Returns the size of the collection.
    #
    # @return [Fixnum]
    def size
      collection.size
    end

    # Returns the collection as a String.
    #
    # @return [String]
    def to_s
      collection.map(&:to_s).join
    end

  end # Collection

end # Vedeu
