require_relative '../repositories/interface'
require_relative '../support/terminal'

module Vedeu
  module Output
    extend self

    def render
      Repositories::Interface.refresh.each do |interface|
        Terminal.output(interface)
      end
    end
  end
end
