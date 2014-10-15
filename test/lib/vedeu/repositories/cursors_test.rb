require 'test_helper'

module Vedeu
  describe Cursors do

    before { Cursors.reset; Interfaces.add({ name: 'chromium' }) }

    describe '#add' do
      it 'raises an exception if the attributes does not have a :name key' do
        attributes = { no_name_key: '' }

        proc { Cursors.add(attributes) }.must_raise(MissingRequired)
      end

      it 'returns something' do
        skip
      end
    end

    describe '#update' do
      let(:attributes) { { name: 'chromium' } }

      it 'returns a new Cursor after updating' do
        Cursors.update(attributes).must_be_instance_of(Cursor)
      end

      context 'when the attributes do not have the :name key' do
        let(:attributes) { { no_name_key: 'some_value' } }

        it { Cursors.update(attributes).must_equal(false) }
      end
    end

  end
end
