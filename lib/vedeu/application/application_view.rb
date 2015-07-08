require_relative 'view'

module Vedeu

  # Provides the mechanism to render views for the client application.
  #
  # @api private
  class ApplicationView

    include Vedeu::View

    # Renders the view.
    #
    # @param args [void]
    # @return [void]
    def self.render(*args)
      new(args).render
    end

    # Returns a new instance of Vedeu::ApplicationView.
    #
    # @param args [void]
    # @return [Vedeu::ApplicationView]
    def initialize(*args)
      @args = args
    end

    protected

    # @!attribute [r] args
    # @return [void]
    attr_reader :args

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
