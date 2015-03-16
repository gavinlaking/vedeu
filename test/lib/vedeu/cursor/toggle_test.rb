require 'test_helper'

module Vedeu

  describe Toggle do

    let(:described) { Toggle.new(cursor) }
    let(:cursor)    { Cursor.new({ name: 'vanadium',
                                   ox: 1,
                                   oy: 1,
                                   state: state,
                                   x: 1,
                                   y: 1 }) }
    let(:state)     { true }

    describe '#initialize' do
      it { described.must_be_instance_of(Toggle) }
      it { described.instance_variable_get('@cursor').must_equal(cursor) }
    end

    describe '.hide' do
      subject { Toggle.hide(cursor) }

      it { subject.must_be_instance_of(Cursor) }

      context 'when the cursor is visible' do
        it 'returns a new cursor' do
          subject.wont_equal(cursor)
        end
      end

      context 'when the cursor is invisible' do
        let(:state) { false }

        it 'returns the cursor' do
          subject.must_equal(cursor)
        end
      end
    end

    describe '.show' do
      subject { Toggle.show(cursor) }

      it { subject.must_be_instance_of(Cursor) }

      context 'when the cursor is visible' do
        it 'returns the cursor' do
          subject.must_equal(cursor)
        end
      end

      context 'when the cursor is invisible' do
        let(:state) { false }

        it 'returns a new cursor' do
          subject.wont_equal(cursor)
        end
      end
    end

  end # Toggle

end # Vedeu
