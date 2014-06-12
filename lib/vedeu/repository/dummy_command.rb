module Vedeu
  class DummyCommand
    def self.dispatch(value = :dummy)
      value || :dummy
    end
  end
end
