require 'test_helper'

module Vedeu

  describe Cursors do

    let(:described) { Cursors }

    before { Cursors.reset }

    describe '#by_name' do
      subject { described.by_name(cursor_name) }

      it { return_type_for(described.by_name('zinc'), Cursor) }

      context 'when the cursor exists' do
        let(:cursor_name) { 'niobium' }

        before { Cursor.new('niobium', false, 7, 9).store }

        it 'has the same attributes it was stored with' do
          subject.x.must_equal(7)
          subject.y.must_equal(9)
        end
      end

      context 'when the cursor does not exist' do
        let(:cursor_name) { 'zinc'}

        it 'is created, stored and has the default attributes' do
          subject.x.must_equal(1)
          subject.y.must_equal(1)
        end
      end
    end

    describe '#current' do
      before { Focus.stubs(:current).returns('francium') }

      subject { described.current }

      it { return_type_for(subject, Cursor) }

      context 'when the cursor exists' do
        before { Cursor.new('francium', false, 12, 4).store }

        it 'has the same attributes it was stored with' do
          subject.x.must_equal(12)
          subject.y.must_equal(4)
        end
      end

      context 'when the cursor does not exist' do
        it 'is created, stored, and has the default attributes' do
          subject.x.must_equal(1)
          subject.y.must_equal(1)
        end
      end
    end

  end # Cursors

end # Vedeu

# {
#   Cursors: {
#     'name' => Cursor[name, state, x, y],
#     'name' => Cursor[name, state, x, y],
#     'name' => Cursor[name, state, x, y],
#   }
# }
