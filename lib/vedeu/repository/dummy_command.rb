module Vedeu
  class DummyCommand
    def self.dispatch(value = :dummy)
      value
    end
  end
end
