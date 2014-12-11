require 'test_helper'

module Vedeu

  describe Key do

    let(:input)  { '' }
    let(:output) { proc { :output } }

    describe '#initialize' do
      it 'returns a new instance of Key' do
        Key.new(input, output).must_be_instance_of(Key)
      end
    end

    describe '#input' do
      it 'returns the key defined' do
        Key.new('a', output).input.must_equal('a')
      end

      context 'alias method #key' do
        it { Key.new('a', output).key.must_equal('a') }
      end
    end

    describe '#output' do
    end

    describe '#press' do
      it 'returns the result of calling the proc' do
        Key.new(input, output).press.must_equal(:output)
      end

      it 'returns a :noop when the output is not a proc' do
        Key.new(input, :output).press.must_equal(:noop)
      end
    end

  end # Key

end # Vedeu
