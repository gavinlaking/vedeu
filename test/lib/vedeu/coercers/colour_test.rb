require 'test_helper'

module Vedeu

  module Coercers

    describe Colour do

      let(:described) { Vedeu::Coercers::Colour }
      let(:instance)  { described.new(_value) }
      let(:_value)    {}

      describe '#initialize' do
        it { instance.must_be_instance_of(described) }
        it { instance.instance_variable_get('@value').must_equal(_value) }
      end

      describe '.coerce' do
        subject { described.coerce(_value) }

        context 'when the value is nil' do
          it { proc { subject }.must_raise(Vedeu::Error::InvalidSyntax) }
        end

        context 'when the value is a Vedeu::Colours::Background' do
          let(:_value) { Vedeu::Colours::Background.new }

          # it { skip }
        end

        context 'when the value is a Vedeu::Colours::Colour' do
          let(:_value) { Vedeu::Colours::Colour.new }

          # it { skip }
        end

        context 'when the value is a Vedeu::Colours::Foreground' do
          let(:_value) { Vedeu::Colours::Foreground.new }

          # it { skip }
        end
      end

      describe '#coerce' do
        it { instance.must_respond_to(:coerce) }
      end

    end # Colour

  end # Coercers

end # Vedeu
