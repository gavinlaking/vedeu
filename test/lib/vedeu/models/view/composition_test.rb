require 'test_helper'

module Vedeu

  describe Composition do

    let(:described)  { Composition.new(interfaces) }
    let(:interfaces) { [] }
    let(:colour)     {}
    let(:style)      {}
    let(:interface_collection) {
      Vedeu::Model::Interfaces.new(interfaces, nil, described)
    }

    before do
      Vedeu::Model::Interfaces.stubs(:new).returns(interface_collection)
    end

    describe '.build' do
      subject {
        Composition.build(interfaces, colour, style) do
          # ...
        end
      }

      it { return_type_for(subject, Composition) }
    end

    describe '#initialize' do
      it { return_type_for(described, Composition) }
      it { assigns(described, '@interfaces', interface_collection) }
      it { assigns(described, '@colour', colour) }
      it { assigns(described, '@style', style) }
    end

    describe '#deputy' do
      it { return_type_for(described.deputy, DSL::Composition) }
    end

  end # Composition

end # Vedeu
