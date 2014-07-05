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
        if interface.is_a?(Array)
          interface.each { |stream| Terminal.output(stream) if stream }
        elsif interface.is_a?(String)
          Terminal.output(interface)
        end
      end
    end
  end
end
