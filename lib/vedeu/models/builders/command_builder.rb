require_relative 'builder'
require_relative '../../repository/command_repository'

module Vedeu
  class CommandBuilder < Builder
    def repository
      CommandRepository
    end
  end
end
