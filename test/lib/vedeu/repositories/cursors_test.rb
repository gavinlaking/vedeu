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

    describe '#use' do
      it 'returns something' do
        skip
      end
    end

  end
end
