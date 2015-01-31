require 'test_helper'

module Vedeu

  describe ToggleCursor do

    let(:described) { ToggleCursor.new(cursor) }
    let(:cursor)    { Cursor.new({ name: 'vanadium',
                                   ox: 1,
                                   oy: 1,
                                   state: true,
                                   x: 1,
                                   y: 1 }) }

    describe '#initialize' do
      it { described.must_be_instance_of(ToggleCursor) }
      it { described.instance_variable_get('@cursor').must_equal(cursor) }
    end

    describe '.hide' do
      subject { ToggleCursor.hide(cursor) }

      it { subject.must_be_instance_of(Cursor) }
    end

    describe '.show' do
      subject { ToggleCursor.show(cursor) }

      it { subject.must_be_instance_of(Cursor) }
    end

  end # ToggleCursor

end # Vedeu
