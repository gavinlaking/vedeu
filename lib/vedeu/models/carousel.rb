module Vedeu

  #
  # A Carousel is a special array-like data structure.
  #
  class Carousel

    include Enumerable

    def initialize(storage = [])
      @storage = storage
    end

    # Add an element to the carousel unless it is already added.
    #
    # @param element []
    # @param focus [Boolean] When true, prepends the element to the
    #   collection, making that element the 'current' element.
    # @return [Array] The collection of elements.
    def add(element, focus = false)
      if registered?(element)
        return self unless focus

        by_element(element)

      elsif focus
        Carousel.new(storage.unshift(element))

      else
        Carousel.new(storage.push(element))

      end
    end

    # Return all the elements in the carousel.
    #
    # @return [Array]
    def all
      storage
    end
    alias_method :registered, :all

    # Change to an element by value and make it current.
    #
    # @param element [] The element to make current.
    # @raise [ModelNotFound] When the element cannot be found.
    # @return [] The current element.
    def by_element(element)
      fail ModelNotFound unless registered?(element)

      Carousel.new(storage.rotate!(storage.index(element)))
    end

    # Return the current element.
    #
    # @return []
    def current
      storage.first
    end

    # Returns a boolean indicating whether the element is current.
    #
    # @param element [String]
    # @return [Boolean]
    def current?(element)
      current == element
    end

    def each(&block)
      storage.each do |element|
        if block_given?
          block.call(element)

        else
          yield element

        end
      end
    end

    # Returns a boolean indicating whether the carousel is empty.
    #
    # @return [Boolean]
    def empty?
      storage.empty?
    end

    # Make the next element relative to the current the new current element.
    #
    # @return [String]
    def next_item
      if empty?
        self

      else
        Carousel.new(storage.rotate!)

      end
    end

    # Make the previous element relative to the current the new current element.
    #
    # @return [String]
    def prev_item
      if empty?
        self

      else
        Carousel.new(storage.rotate!(-1))

      end
    end
    alias_method :previous_item, :prev_item

    # Return a boolean indicating whether the element is currently in the
    # carousel.
    #
    # @param element []
    # @return [Boolean]
    def registered?(element)
      storage.include?(element)
    end

    # Reset the carousel.
    #
    # @return [Carousel]
    def reset
      Carousel.new
    end

    private

    attr_reader :storage

  end # Carousel

end # Vedeu
