module Vedeu
  class DummyCommand
    attr_accessor :name

    def self.dispatch(value = :dummy)
      value || :dummy
    end
  end
end
