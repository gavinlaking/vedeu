require_relative '../repository/interface_repository'
require_relative '../support/terminal'

module Vedeu
  class Output
    def self.render
      new.render
    end

    def initialize; end

    def render
      InterfaceRepository.refresh.each do |interface|
        Terminal.output(interface)
      end
    end
  end
end
