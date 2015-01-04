require 'test_helper'

module Vedeu

  describe Buffers do

    let(:described) { Vedeu::Buffers }
    let(:instance)  { described.new(model, storage) }
    let(:model)     { Vedeu::Buffer }
    let(:storage)   { {} }

    describe '#initialize' do
      subject { instance }

      it { return_type_for(subject, Vedeu::Buffers) }
      it { assigns(subject, '@model', model) }
      it { assigns(subject, '@storage', storage) }
    end

    describe '#add_content' do
      let(:attributes) {
        {
          name: 'molybdenum'
        }
      }

      subject { instance.add_content(attributes) }

      context 'when the buffer is registered' do
        let(:storage) { { 'molybdenum' => Buffer.new(attributes) } }

        it { return_type_for(subject, TrueClass) }
      end

      context 'when the buffer is not registered' do
        it { return_type_for(subject, TrueClass) }
      end
    end

  end # Buffers

end # Vedeu
