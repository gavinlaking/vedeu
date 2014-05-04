class Interfaces
  def self.default
    new do |interface|
      interface.add(:dummy)
    end
  end

  def self.define(&block)
    new(&block)
  end

  def initialize(&block)
    @interfaces ||= {}

    block.call(self)

    interfaces
  end

  def add(name, klass = Vedeu::DummyInterface, options = {})
    interfaces.merge!(name => Proc.new { klass.new(options) })

    interfaces
  end

  def show
    interfaces
  end

  def run
    interfaces.values.map { |interface| interface.call.run }

    interfaces
  end

  private
  attr_accessor :interfaces
end
