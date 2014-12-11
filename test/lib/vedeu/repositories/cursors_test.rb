require 'test_helper'

module Vedeu

  describe Cursors do

    before do
      Cursors.reset
      Offsets.reset
      Registrar.record({ name: 'chromium' })
    end

    describe '#add' do
      let(:attributes) { { name: 'chromium' } }

      it 'raises an exception if a :name attribute is not provided' do
        proc { Offsets.add({ no_name: 'no_name' }) }
          .must_raise(MissingRequired)
      end

      it 'returns a new instance of Offset once stored' do
        Offsets.add({ name: 'praseodymium' }).must_be_instance_of(Offset)
      end

      it 'returns a new Cursor after registering' do
        Cursors.add(attributes).must_be_instance_of(Cursor)
      end

      it 'returns a new Cursor after updating' do
        Cursors.update(attributes).must_be_instance_of(Cursor)
      end

      context 'when the attributes do not have the :name key' do
        let(:attributes) { { no_name_key: 'some_value' } }

        it 'raises an exception' do
          proc { Cursors.update(attributes) }.must_raise(MissingRequired)
        end

        it 'raises an exception' do
          proc { Cursors.add(attributes) }.must_raise(MissingRequired)
        end
      end
    end

    describe '#hide' do
      it 'sets the state attribute of the Cursor to :hide' do
        cursor = Cursors.hide
        cursor.state.must_equal(:hide)
      end
    end

    describe '#show' do
      it 'sets the state attribute of the Cursor to :show' do
        cursor = Cursors.show
        cursor.state.must_equal(:show)
      end
    end

  end # Cursors

end # Vedeu
