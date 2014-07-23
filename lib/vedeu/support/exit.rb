require_relative '../../vedeu'

module Vedeu
  class Exit
    def self.dispatch
      Vedeu.trigger(:_exit_)
    end
  end
end
