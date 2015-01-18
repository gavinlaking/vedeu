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
        described.build(interfaces, colour, style) do
          # ...
        end
      }

      it { return_type_for(subject, Composition) }
    end

    describe '#initialize' do
      subject { instance }

      it { return_type_for(subject, described) }
      it { assigns(subject, '@interfaces', interface_collection) }
      it { assigns(subject, '@colour', colour) }
      it { assigns(subject, '@style', style) }
    end

  end # Composition

end # Vedeu
