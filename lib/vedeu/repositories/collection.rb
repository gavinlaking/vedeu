# frozen_string_literal: true

module Vedeu

  module Repositories

    # Convert an Array into an object which has some meaning in the
    # context it is being used.
    #
    # @api private
    #
    class Collection

      include Vedeu::Repositories::Assemblage

      # @!attribute [r] collection
      # @return [Array|Vedeu::Repositories::Collection]
      attr_reader :collection
      alias_method :all, :collection
      alias_method :value, :collection

      # @!attribute [rw] parent
      # @return [Fixnum]
      attr_accessor :parent

      # @!attribute [rw] name
      # @return [String|Symbol|NilClass]
      attr_accessor :name

      # @param collection [Array|Vedeu::Repositories::Collection]
      # @param parent [void]
      # @param name [String|Symbol|NilClass]
      # @return [Vedeu::Repositories::Collection]
      def self.coerce(collection = [], parent = nil, name = nil)
        if collection.is_a?(Vedeu::Repositories::Collection)
          collection

        else
          new(Array(collection), parent, name)

        end
      end

      # Returns a new instance of Vedeu::Repositories::Collection.
      #
      # @param collection [void]
      # @param parent [void]
      # @param name [String|Symbol|NilClass]
      # @return [Vedeu::Repositories::Collection]
      def initialize(collection = [], parent = nil, name = nil)
        @collection = collection
        @parent     = parent
        @name       = name
      end

      # Adds an entry to the collection.
      #
      # @param other [Vedeu::Repositories::Collection]
      # @return [Vedeu::Repositories::Collection]
      def add(other)
        if other.is_a?(Vedeu::Repositories::Collection)
          return self.class.coerce(other, parent, name) if empty?

        else
          self.class.new(@collection += Array(other), parent, name)

        end
      end
      alias_method :<<, :add

      # Returns the collection as a String.
      #
      # @return [String]
      def to_s
        collection.map(&:to_s).join
      end
      alias_method :to_str, :to_s

    end # Collection

  end # Repositories

end # Vedeu
