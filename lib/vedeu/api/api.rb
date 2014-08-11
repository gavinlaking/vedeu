module Vedeu
  module API
    def interface(name, &block)
      API::Interface.save(name, &block)
    end

    def log(message)
      API::Log.logger.debug(message)
    end
  end

  extend API
end
