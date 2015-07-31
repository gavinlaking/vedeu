module Vedeu

  # Provides methods which should be available to all client application
  # controllers. The client application's ApplicationController will inherit
  # from this class.
  #
  class ApplicationController

    include Vedeu::Controller

    # @param params [Hash] The named parameters provided to the controller which
    #   will be used by the actions within the controller.
    # @return [Vedeu::ApplicationController]
    def initialize(**params)
      @params = params
    end

    # @param controller [Symbol] The name of controller to be redirected to.
    # @param action [Symbol] The name of the action within the controller to be
    #   called.
    # @param params [Hash] Any named parameter which need to be passed to the
    #   action.
    def redirect_to(controller, action, **params)
      Vedeu.trigger(:_goto_, controller, action, params)
    end
    alias_method :redirect, :redirect_to
    alias_method :goto, :redirect_to

    protected

    # @!attribute [rw] params
    # @return [Hash] The named parameters passed to the controller.
    attr_accessor :params

  end # ApplicationController

end # Vedeu
