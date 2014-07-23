require_relative 'builder'
require_relative '../../repositories/command_repository'

module Vedeu
  class CommandBuilder < Builder
    def repository
      Repositories::CommandRepository
    end
  end
end
