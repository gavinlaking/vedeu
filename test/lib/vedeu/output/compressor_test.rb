require 'test_helper'

module Vedeu

  describe Compressor do

    let(:described) { Vedeu::Compressor }
    let(:instance)  { described.new(output) }
    let(:output)    {}

    describe '#initialize' do
      it { instance.must_be_instance_of(Vedeu::Compressor) }
      it { instance.instance_variable_get('@output').must_equal(output) }
    end

    describe '#render' do
      subject { instance.render }

      it { subject.must_be_instance_of(String) }

      context 'when the output is all Vedeu::Char elements' do

      end

      context 'when the output is not all Vedeu::Char elements' do
        let(:output) {
          [
            Vedeu::Char.new(value: 'N'),
            'o',
            Vedeu::Char.new(value: 't'),
          ]
        }
        it 'converts the non-Vedeu::Char elements into String elements' do
          subject.must_equal('Not')
        end
      end
    end

  end # Compressor

end # Vedeu
