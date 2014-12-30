require 'test_helper'

module Vedeu

  describe ToggleCursor do
    let(:described) { ToggleCursor.new(cursor) }
    let(:cursor)    { Cursor.new('vanadium', true, 1, 1) }

    describe '#initialize' do
      it { return_type_for(described, ToggleCursor) }
      it { assigns(described, '@cursor', cursor) }
    end

    describe '.hide' do
      subject { ToggleCursor.hide(cursor) }

      it { return_type_for(subject, Cursor) }
    end

    describe '.show' do
      subject { ToggleCursor.show(cursor) }

      it { return_type_for(subject, Cursor) }
    end

  end # ToggleCursor

end # Vedeu
