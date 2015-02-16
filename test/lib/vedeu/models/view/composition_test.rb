require 'test_helper'

module Vedeu

  describe Composition do

    let(:described)  { Vedeu::Composition }
    let(:instance)   { described.new(attributes) }
    let(:attributes) {
      {
        interfaces: interfaces,
        colour:     colour,
        style:      style,
      }
    }
    let(:interfaces) { [] }
    let(:colour)     {}
    let(:style)      {}

    describe '.build' do
      subject {
        described.build({}) do
          # ...
        end
      }

      it { subject.must_be_instance_of(described) }
    end

    describe '#initialize' do
      subject { instance }

      it { subject.must_be_instance_of(described) }
      it { subject.instance_variable_get('@interfaces').must_equal(interfaces) }
      it { subject.instance_variable_get('@colour').must_be_instance_of(Vedeu::Colour) }
      it { subject.instance_variable_get('@style').must_be_instance_of(Vedeu::Style) }
    end

    describe '#inspect' do
      subject { instance.inspect }

      it { subject.must_equal('<Vedeu::Composition (interfaces:0)>') }
    end

  end # Composition

end # Vedeu
