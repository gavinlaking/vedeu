require_relative '../repository/interface_repository'
require_relative '../support/terminal'

module Vedeu
  module Output
    extend self

    def render
      InterfaceRepository.refresh.each do |interface|
        Terminal.output(interface)
      end
    end
  end
end
