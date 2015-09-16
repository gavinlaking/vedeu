module Vedeu

  # When included into a class, provides the mechanism to store the
  # class in a repository for later retrieval.
  #
  module Model

    include Vedeu::Common

    # @!attribute [rw] repository
    # @return [Vedeu::Repository]
    attr_accessor :repository

    # When {Vedeu::Model} is included in a class, the methods within
    # this module are included as class methods on that class.
    #
    module ClassMethods

      # @!attribute [r] repository
      # @return [Vedeu::Repository]
      attr_reader :repository

      # Build models using a simple DSL when a block is given,
      # otherwise returns a new instance of the class including this
      # module.
      #
      # @param attributes [Hash] A collection of attributes specific
      #   to the model.
      # @param block [Proc] The block passed to the build method.
      # @return [Object] An instance of the model.
      def build(attributes = {}, &block)
        attributes = defaults.merge!(attributes)

        model = new(attributes)
        model.deputy(attributes[:client]).instance_eval(&block) if block_given?
        model
      end

      # Fetch an instance of a repository's model by name.
      #
      # @param name [String]
      # @return [void]
      def by_name(name)
        repository.by_name(name) if repository
      end

      # Provide a convenient way to define the child or children of a
      # model.
      #
      # @param klass [Class] The member (singular) or collection
      #   (multiple) class name for the respective model.
      # @return [void]
      def child(klass)
        send(:define_method, __callee__) { klass }
      end
      alias_method :member,     :child
      alias_method :collection, :child

      # Allow models to specify their repository using a class method.
      #
      # @param klass [void]
      # @return [void]
      def repo(klass)
        @repository = klass
      end

      private

      # The default values for a new instance of this class.
      #
      # @return [Hash<Symbol => NilClass, String>]
      def defaults
        {
          client:    nil,
          name:      '',
        }
      end

    end # ClassMethods

    # When this module is included in a class, provide ClassMethods as
    # class methods for the class.
    #
    # @param klass [Class]
    # @return [void]
    def self.included(klass)
      klass.send(:extend, ClassMethods)
    end

    # Returns a DSL instance responsible for defining the DSL methods
    # of this model.
    #
    # @param client [Object|NilClass] The client binding represents
    #   the client application object that is currently invoking a DSL
    #   method. It is required so that we can send messages to the
    #   client application object should we need to.
    # @return [void] The DSL instance for this model.
    def deputy(client = nil)
      Object.const_get(dsl_class).new(self, client)
    end

    # @todo Perhaps some validation could be added here?
    # @return [void] The model instance stored in the repository.
    def store
      repository.store(self) # if valid?
    end

    private

    # Returns the DSL class name responsible for this model.
    #
    # @return [String]
    def dsl_class
      case demodulize(self.class.name)
      when 'Border'   then 'Vedeu::Borders::DSL'
      when 'Buffer'   then 'Vedeu::Buffers::DSL'
      when 'Geometry' then 'Vedeu::Geometry::DSL'
      when 'Menu'     then 'Vedeu::Menus::DSL'
      else
        'Vedeu::DSL::' + demodulize(self.class.name)
      end
    end

  end # Model

end # Vedeu
