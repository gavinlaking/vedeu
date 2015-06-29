module Vedeu

  # Provides view related functionality.
  #
  # @api private
  module ApplicationTemplate

    module_function

    # Renders the view.
    #
    # @param object [void]
    # @return [void]
    def render(object = nil)
      new(object).render
    end

    # @return [String]
    def template(value)
      @template = File.dirname(__FILE__) + "/templates/#{value}.erb"
    end

  end # ApplicationTemplate

  # Provides the mechanism to render views for the client application.
  #
  # @api private
  class ApplicationView

    extend ApplicationTemplate

    # @param object [void]
    # @return [Vedeu::ApplicationView]
    def initialize(object = nil)
      @object = object
    end

    protected

    # @!attribute [r] object
    # @return [void]
    attr_reader :object

    # @!attribute [r] template
    # @return [void]
    attr_reader :template

    private

    # @return [Hash]
    def options
      {
        # mode: :wrap,
        # width:
      }
    end

  end # ApplicationView

end # Vedeu