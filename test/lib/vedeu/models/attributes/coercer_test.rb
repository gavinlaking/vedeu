require 'test_helper'

module Vedeu
  class TestClass
    include Coercions

    def initialize(attributes = {})
      @attributes = attributes
      @name       = attributes[:name]
    end
  end

  describe Coercions do
    describe '.coercer' do
      let(:klass) { mock('TestClass') }

      before do
        TestClass.stubs(:new).returns(klass)
      end

      [nil, [], {}].each do |empty_value|
        it 'returns an empty collection when nil or empty' do
          TestClass.coercer(empty_value).must_equal([])
        end
      end

      it 'returns when an object' do
        TestClass.coercer([klass]).must_equal([klass])
      end

      it 'returns a collection of models when a single hash' do
        coerced = TestClass.coercer({ :name => 'test1' })
        coerced.size.must_equal(1)
        coerced.must_equal([klass])
      end

      it 'returns a collection of models when multiple hashes' do
        coerced = TestClass.coercer([
          { :name => 'test1' }, { :name => 'test2' }
        ])
        coerced.size.must_equal(2)
        coerced.must_equal([klass, klass])
      end

      it 'returns a collection of models when a single array' do
        coerced = TestClass.coercer([{ :name => 'test3' }])
        coerced.size.must_equal(1)
        coerced.must_equal([klass])
      end
    end
  end
end
