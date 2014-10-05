require 'test_helper'

module Vedeu
  describe Cursors do

    before { Cursors.reset }

    describe '#add' do
      it 'raises an exception if the attributes does not have a :name key' do
        attributes = { no_name_key: '' }

        proc { Cursors.add(attributes) }.must_raise(MissingRequired)
      end

      it 'returns something' do
        skip
      end
    end

    describe '#all' do
      it 'returns the repository' do
        Cursors.all.must_equal({})
      end
    end

    describe '#find' do
      it 'returns something' do
        skip
      end
    end

    describe '#registered?' do
      it 'returns false when the name is nil' do
        Cursors.registered?(nil).must_equal(false)
      end

      it 'returns false when the name is empty' do
        Cursors.registered?('').must_equal(false)
      end
    end

    describe '#use' do
      it 'returns something' do
        skip
      end
    end

  end
end
