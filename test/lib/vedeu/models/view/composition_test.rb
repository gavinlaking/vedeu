require 'test_helper'

module Vedeu

  describe Composition do

    let(:described) { Vedeu::Composition }
    let(:instance)  { described.new(interfaces) }

    let(:interfaces) { [] }
    let(:colour)     {}
    let(:style)      {}
    let(:interface_collection) {
      Vedeu::Model::Interfaces.new(interfaces, instance)
    }

    before do
      Vedeu::Model::Interfaces.stubs(:new).returns(interface_collection)
    end

    describe '.build' do
      subject {
        described.build({}) do
          # ...
        end
      }

      it { subject.must_be_instance_of(Composition) }
    end

    describe '#initialize' do
      subject { instance }

      it { subject.must_be_instance_of(described) }
      it { subject.instance_variable_get('@interfaces').must_equal(interface_collection) }
      it { subject.instance_variable_get('@colour').must_equal(colour) }
      it { subject.instance_variable_get('@style').must_equal(style) }
    end

  end # Composition

end # Vedeu
