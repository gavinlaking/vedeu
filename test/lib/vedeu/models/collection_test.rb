require_relative '../../../test_helper'
require_relative '../../../../lib/vedeu/models/collection'

module Vedeu
  class TestClass
    include Collection

    def initialize(*args); end
  end

  describe Collection do
    describe '#coercer' do
      it 'returns an empty collection when the value is nil or empty' do
        Collection.coercer(nil, TestClass, :key).must_equal([])
      end

      it 'returns an empty collection when the value is nil or empty' do
        Collection.coercer('',  TestClass, :key).must_equal([])
      end

      it 'returns an empty collection when the value is nil or empty' do
        Collection.coercer([],  TestClass, :key).must_equal([])
      end

      it 'returns an empty collection when the value is nil or empty' do
        Collection.coercer({},  TestClass, :key).must_equal([])
      end

      it 'returns a single model in a collection when the value is a String' do
        Collection.coercer('test', TestClass, :key).size.must_equal(1)
      end

      it 'returns a collection of models when the value is a single hash' do
        Collection.coercer({ :test1 => 'test1' }, TestClass, :key)
          .size.must_equal(1)
      end

      it 'returns a collection of models when the value is multiple hashes' do
        Collection.coercer([
          { :test1 => 'test1' }, { :test2 => 'test2' }
        ], TestClass, :key).size.must_equal(2)
      end

      it 'returns a collection of models when the value is single array' do
        Collection.coercer([{ :test3 => 'test3' }], TestClass, :key)
          .size.must_equal(1)
      end
    end
  end
end
