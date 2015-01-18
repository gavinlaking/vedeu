require 'test_helper'

module Vedeu

  describe Cursor do

    let(:described)   { Cursor.new(cursor_name, state, x, y) }
    let(:cursor_name) { 'silver' }
    let(:state)       { :show }
    let(:x)           { 19 }
    let(:y)           { 8 }

    describe '#initialize' do
      it { return_type_for(described, Cursor) }

      it { assigns(described, '@name', 'silver') }
      it { assigns(described, '@state', :show) }
      it { assigns(described, '@x', 19) }
      it { assigns(described, '@y', 8) }
      it { assigns(described, '@repository', Vedeu.cursors) }
    end

    describe '#name' do
      it { return_type_for(described.name, String) }

      it { return_value_for(described.name, 'silver') }
    end

    describe '#to_s' do
      let(:visible) { true }

      subject { Cursor.new('silver', visible, 19, 8).to_s }

      it { return_type_for(subject, String) }

      context 'when the cursor is visible' do
        it 'returns an visible cursor escape sequence with position' do
          subject.must_equal("\e[8;19H\e[?25h")
        end
      end

      context 'when the cursor is invisible' do
        let(:visible) { false }

        it 'returns the invisible cursor escape sequence with position' do
          subject.must_equal("\e[8;19H\e[?25l")
        end
      end

      it 'returns the escape sequence to position and set the visibility of ' \
         'the cursor and returns to that position after yielding the block' do
        described.to_s do
          # ...
        end.must_equal("\e[8;19H\e[?25h\e[8;19H\e[?25h")
      end
    end

  end # Cursor

end # Vedeu
