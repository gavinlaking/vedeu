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
    end

    describe '#+' do
    end

    describe '.write' do
    end

  end # Writer

end # Vedeu
