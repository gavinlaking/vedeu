module Vedeu

  # Subclassing Vedeu::View will allow Vedeu to call your #render method.
  # This method should contain attributes required to build a view or views.
  # These attributes will be added to the back buffer of each interface
  # mentioned, to be rendered upon next refresh.
  #
  # @deprecated May disappear in 0.3.0. Prefer {Vedeu::API#render} instead.
  # @see Vedeu::API#render
  # @api private
  class View

    include Vedeu::API

    # @param object []
    # @return [Array]
    def self.render(object = nil)
      new(object).enqueue
    end

    # Returns a new instance of View.
    #
    # @param object []
    # @return [View]
    def initialize(object = nil)
      @object = object
    end

    # @return [Array]
    def enqueue
      composition.interfaces.map do |interface|
        Buffers.add(interface.attributes)
      end
    end

    # @raise [NotImplemented] Subclasses of this class must implement this
    #   method.
    # @return [Exception]
    def render
      fail NotImplemented, 'Implement #render on your subclass of Vedeu::View.'
    end

    private

    attr_reader :object

    # Create a new Composition object with the attributes.
    #
    # @api private
    # @return [Composition]
    def composition
      @_composition ||= Composition.new(attributes)
    end

    # Calls the #render method of the subclass, hopefully receives attributes
    # suitable to create one or more views.
    #
    # @api private
    # @return []
    def attributes
      render
    end

  end # View

end # Vedeu
