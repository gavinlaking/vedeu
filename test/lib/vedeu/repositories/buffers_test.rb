require 'test_helper'

module Vedeu

  describe Buffers do

    let(:described) { Vedeu::Buffers.new(model, storage) }
    let(:model)     { Vedeu::Buffer }
    let(:storage)   { {} }

    describe '#initialize' do
      it { return_type_for(described, Vedeu::Buffers) }
      it { assigns(described, '@model', model) }
      it { assigns(described, '@storage', storage) }
    end

    describe '#add_content' do
      let(:attributes) {
        {
          name: 'molybdenum'
        }
      }

      subject { described.add_content(attributes) }

      context 'when the content was added to the buffer' do
        it { return_type_for(subject, TrueClass) }
      end

      # context 'when the attributes do not have a :name key' do
      #   attributes = { no_name_key: '' }

      #   it { proc { Buffers.add_content(attributes) }.must_raise(MissingRequired) }
      # end
    end

  end # Buffers

end # Vedeu
