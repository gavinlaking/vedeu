require 'erb'

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

  attr_accessor :borders,
    :configuration,
    :events,
    :geometries,
    :interfaces,
    :keymaps,
    :menus,
    :views

  # @return [String]
  def self.build(attributes = {}, &block)
    new(attributes).build(&block)
  end

  # @return [TestApplication]
  def initialize(attributes = {})
    @attributes = defaults.merge(attributes)

    @attributes.each do |k, v|
      instance_variable_set("@#{k.to_s}", @attributes[k])
    end
  end

  # @return [String]
  def build(&block)
    self.instance_eval(&block) if block_given?

    @object = self

    ERB.new(application, nil, '-').result(binding)
  end

  # @return [String]
  def lib_dir
    File.dirname(__FILE__) + "/../../../lib"
  end

  private

  # @return [String]
  def application
    @application ||= read('default_application.vedeu')
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
