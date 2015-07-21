require 'vedeu/application/controller'

module Vedeu

  # Provides methods which should be available to all client application
  # controllers. The client application's ApplicationController will inherit
  # from this class.
  #
  # @api private
  class ApplicationController

    include Vedeu::Controller

  end # ApplicationController

end # Vedeu
