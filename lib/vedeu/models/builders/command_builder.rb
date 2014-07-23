require_relative 'builder'
require_relative '../../repositories/command'

module Vedeu
  class CommandBuilder < Builder
    def repository
      Repositories::Command
    end
  end
end
