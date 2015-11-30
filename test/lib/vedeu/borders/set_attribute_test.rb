require 'test_helper'

module Vedeu

  module Borders

    describe SetAttribute do

      let(:described) { Vedeu::Borders::SetAttribute }
      let(:instance)  { described.new(_name, attribute, _value) }
      let(:_name)     {}
      let(:attribute) {}
      let(:_value)    {}
      let(:border)    {
        Vedeu::Borders::Border.new(name: _name)
      }

      describe '#initialize' do
        it { instance.must_be_instance_of(described) }
        it { instance.instance_variable_get('@name').must_equal(_name) }
        it { instance.instance_variable_get('@attribute').must_equal(attribute) }
        it { instance.instance_variable_get('@value').must_equal(_value) }
      end

      describe '.update' do
        let(:_name)     { 'Vedeu::Borders::SetAttribute' }
        let(:attribute) { :title }

        subject { described.update(_name, attribute, _value) }

        it { subject.must_be_instance_of(Vedeu::Borders::Border) }

        context 'when a name is given' do
          context 'when an attribute is given' do
            context 'when a value is given' do
              let(:_value) { 'Other value' }

              it { subject.send(attribute).must_equal(_value) }
            end

            context 'when a value is not given' do
              it { subject.send(attribute).must_equal('') }
            end
          end

          context 'when an attribute is not given' do
            let(:attribute) {}

            it { proc { subject }.must_raise(Vedeu::Error::MissingRequired) }
          end
        end
      end

      describe '#update' do
        it { instance.must_respond_to(:update) }
      end

    end # SetAttribute

  end # Borders

end # Vedeu
