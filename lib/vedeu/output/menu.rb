module Vedeu
  class Menu
    attr_accessor :label, :value

    def initialize(attributes = {})
      @attributes = attributes || {}
    end

    def label
      attributes[:label] || defaults[:label]
    end

    def value
      attributes[:value] || defaults[:value]
    end

    private

    def defaults
      {
        label: '',
        value: ''
      }
    end
  end
end
