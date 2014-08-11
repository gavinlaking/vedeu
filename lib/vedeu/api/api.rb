module Vedeu
  module API
    def interface(name, &block)
      API::Interface.save(name, &block)
    end

    def log(message)
      API::Log.logger.debug(message)
    end

    # def render(object = nil)
    #   Vedeu::View.render(object)
    # end

    def view(name, &block)
      API::View.build(name, &block)
    end
  end

  extend API
end
