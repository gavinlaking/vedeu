require_relative 'view'

module Vedeu

  # Provides the mechanism to render views for the client application.
  #
  # @api private
  class ApplicationView

    include Vedeu::View

    # Renders the view.
    #
    # @param object [void]
    # @return [void]
    def self.render(object = nil)
      new(object).render
    end

    # Returns a new instance of Vedeu::ApplicationView.
    #
    # @param object [void]
    # @return [Vedeu::ApplicationView]
    def initialize(object = nil)
      @object = object
    end

    protected

    # @!attribute [r] object
    # @return [void]
    attr_reader :object

    # # @!attribute [r] template
    # # @return [void]
    # attr_reader :template

    private

    # @param value [String]
    # @return [String]
    def template(value)
      @template = Vedeu::Configuration.base_path +
        "/app/views/templates/#{value}.erb"
    end

  end # ApplicationView

end # Vedeu
