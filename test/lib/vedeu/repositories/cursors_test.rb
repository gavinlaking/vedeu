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

    describe '#build' do
      let(:attributes) { { name: 'chromium' } }

      before { Cursors.add(attributes) }
      after  { Cursors.reset }

      it 'returns a new instance of Cursor based on the stored attributes' do
        Cursors.build('chromium').must_be_instance_of(Cursor)
      end

      context 'when the cursor cannot be found' do
        it 'raises an exception' do
          proc { Cursors.build('ununtrium') }.must_raise(CursorNotFound)
        end
      end
    end

    describe '#update' do
      let(:attributes) { { name: 'chromium' } }

      it 'returns the attributes after updating' do
        Cursors.update(attributes).must_equal(attributes)
      end

      context 'when the attributes do not have the :name key' do
        let(:attributes) { { no_name_key: 'some_value' } }

        it { Cursors.update(attributes).must_equal(false) }
      end
    end

  end
end
