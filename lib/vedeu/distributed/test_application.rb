module Vedeu

  # Create a test application as a string.
  #
  # @example
  #   test_app = TestApplication.build do |app|
  #     app.borders       = ''
  #     app.configuration = ''
  #     app.events        = ''
  #     app.geometries    = ''
  #     app.interfaces    = ''
  #     app.keymaps       = ''
  #     app.menus         = ''
  #     app.views         = ''
  #   end
  #
  class TestApplication

    # @!attribute [rw] borders
    # @return [String]
    attr_accessor :borders

    # @!attribute [rw] configuration
    # @return [String]
    attr_accessor :configuration

    # @!attribute [rw] events
    # @return [String]
    attr_accessor :events

    # @!attribute [rw] geometries
    # @return [String]
    attr_accessor :geometries

    # @!attribute [rw] interfaces
    # @return [String]
    attr_accessor :interfaces

    # @!attribute [rw] keymaps
    # @return [String]
    attr_accessor :keymaps

    # @!attribute [rw] menus
    # @return [String]
    attr_accessor :menus

    # @!attribute [rw] views
    # @return [String]
    attr_accessor :views

    # @param (see #initialize)
    def self.build(attributes = {}, &block)
      new(attributes).build(&block)
    end

    # Returns a new instance of Vedeu::TestApplication.
    #
    # @param attributes [Hash<Symbol => String>]
    # @option attributes borders [String]
    # @option attributes configuration [String]
    # @option attributes events [String]
    # @option attributes geometries [String]
    # @option attributes interfaces [String]
    # @option attributes keymaps [String]
    # @option attributes menus [String]
    # @option attributes views [String]
    # @return [TestApplication]
    def initialize(attributes = {})
      @attributes = defaults.merge!(attributes)

      @attributes.each { |k, _| instance_variable_set("@#{k}", @attributes[k]) }
    end

    # @param block [Proc]
    # @return [String]
    def build(&block)
      instance_eval(&block) if block_given?

      Vedeu::Template.parse(self, template)
    end

    # @return [String]
    def lib_dir
      File.dirname(__FILE__) + '/../../../lib'
    end

    private

    # @return [String]
    def template
      File.dirname(__FILE__) + '/templates/default_application.vedeu'
    end

    # @todo Don't like all this file reading.
    #
    # @return [Hash]
    def defaults
      {
        borders:       read('default_borders.vedeu'),
        configuration: read('default_configuration.vedeu'),
        events:        read('default_events.vedeu'),
        geometries:    read('default_geometries.vedeu'),
        interfaces:    read('default_interfaces.vedeu'),
        keymaps:       read('default_keymaps.vedeu'),
        menus:         read('default_menus.vedeu'),
        views:         read('default_views.vedeu'),
      }
    end

    # @return [String]
    def read(filename)
      File.read(File.dirname(__FILE__) + '/templates/' + filename)
    end

  end # TestApplication

end # Vedeu
