require 'test_helper'

module Vedeu

  describe Writer do

    describe '.[]' do
      it 'returns a new instance of Writer' do
        Writer[:null, :file, :screen].must_be_instance_of(Writer)
      end
    end

    describe '#initialize' do
      it 'returns an instance of itself' do
        writers = :null

        Writer.new(writers).must_be_instance_of(Writer)
      end
    end

    describe '#==' do
      context 'when the two objects are the same' do
        it { skip;subject.must_equal(true) }
      end

      context 'when the two objects are not the same' do
        it { skip;subject.must_equal(false) }
      end
    end

    describe '#+' do
      it 'returns the collection of writers' do
        skip
      end
    end

    describe '.write' do
      it 'not sure if this should be here' do
        skip
      end
    end

  end # Writer

end # Vedeu
