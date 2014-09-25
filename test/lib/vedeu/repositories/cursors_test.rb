require 'test_helper'

module Vedeu
  describe Cursors do

    describe '#add' do
      it 'raises an exception if the attributes does not have a :name key' do
        attributes = { no_name_key: '' }

        proc { Cursors.add(attributes) }.must_raise(MissingRequired)
      end

      it 'returns something' do
        skip
      end
    end

  end
end
