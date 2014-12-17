require 'test_helper'

module Vedeu

  describe Key do

    let(:described) { Key.new(input, output) }
    let(:input)     { '' }
    let(:output)    { Proc.new { :output } }

    describe '#initialize' do
      it { return_type_for(described, Key) }
      it { assigns(described, '@input', input) }

      it { skip; assigns(described, '@output', output) }
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
