module Vedeu
  class DummyCommand
    attr_accessor :id

    def self.dispatch(value = :dummy)
      value || :dummy
    end
  end
end
