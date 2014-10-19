require 'test_helper'

module Vedeu
  describe Cursors do

    before do
      Cursors.reset
      Interfaces.add({ name: 'chromium' })
    end

    describe '#add' do
      let(:attributes) { { name: 'chromium' } }

      it 'returns a new Cursor after updating' do
        Cursors.update(attributes).must_be_instance_of(Cursor)
      end

      context 'when the attributes do not have the :name key' do
        let(:attributes) { { no_name_key: 'some_value' } }

        it 'raises an exception' do
          proc { Cursors.update(attributes) }.must_raise(MissingRequired)
        end
      end
    end

  end
end
