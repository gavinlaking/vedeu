require 'test_helper'

module Vedeu

  describe Cursor do

    let(:described)  { Cursor.new(attributes) }
    let(:attributes) {
      {
        name:  'silver',
        state: :show,
        x:     19,
        y:     8
      }
    }

    before do
      Interfaces.reset
      Vedeu.interface 'silver' do
        y      5
        height 4
        x      12
        width  10
      end
      Terminal.console.stubs(:print)
    end

    describe '#initialize' do
      it { return_type_for(described, Cursor) }
      it { assigns(described, '@attributes', attributes) }
      it { assigns(described, '@name', 'silver') }
      it { assigns(described, '@state', :show) }
      it { assigns(described, '@x', 19) }
      it { assigns(described, '@y', 8) }
    end

    describe '#attributes' do
      it 'returns a hash containing the attributes of the instance' do
        described.attributes.must_equal(
          { name: 'silver', state: :show, x: 19, y: 8 }
        )
      end
    end

    describe '#x' do
      it { return_type_for(described.x, Fixnum) }

      context 'when the cursors position is outside the interface' do
        let(:attributes) { { name: 'silver', state: :show, x: 10, y: 8 } }

        it 'repositions the cursor at the start of the line' do
          Cursor.new(attributes).attributes.must_equal(
            { name: 'silver', state: :show, x: 12, y: 8 }
          )
        end
      end

      context 'when the cursors position is outside the interface' do
        let(:attributes) { { name: 'silver', state: :show, x: 25, y: 8 } }

        it 'repositions the cursor at the end of the line' do
          Cursor.new(attributes).attributes.must_equal(
            { name: 'silver', state: :show, x: 22, y: 8 }
          )
        end
      end
    end

    describe '#y' do
      it { return_type_for(described.y, Fixnum) }

      context 'when the cursors position is outside the interface' do
        let(:attributes) { { name: 'silver', state: :show, x: 19, y: 3 } }

        it 'repositions the cursor at the start of the line' do
          described.attributes.must_equal(
            { name: 'silver', state: :show, x: 19, y: 5 }
          )
        end
      end

      context 'when the cursors position is outside the interface' do
        let(:attributes) { { name: 'silver', state: :show, x: 19, y: 12 } }

        it 'repositions the cursor at the end of the line' do
          described.attributes.must_equal(
            { name: 'silver', state: :show, x: 19, y: 9 }
          )
        end
      end
    end

    describe '#refresh' do
      it 'returns a hash containing the attributes of the instance' do
        described.refresh.must_equal(
          { name: 'silver', state: :show, x: 19, y: 8 }
        )
      end
    end

    describe '#show' do
      it 'sets the state attribute to :show' do
        cursor = described
        cursor.hide
        cursor.attributes.must_equal(
          { name: 'silver', state: :hide, x: 19, y: 8 }
        )
        cursor.show
        cursor.attributes.must_equal(
          { name: 'silver', state: :show, x: 19, y: 8 }
        )
      end
    end

    describe '#hide' do
      it 'sets the state attribute to :hide' do
        cursor = described
        cursor.hide
        cursor.attributes.must_equal(
          { name: 'silver', state: :hide, x: 19, y: 8 }
        )
        cursor.to_s.must_equal("\e[8;19H\e[?25l")
      end
    end

    describe '#to_s' do
      context 'when the cursor state is :show' do
        it 'returns an escape sequence for showing the cursor (and position)' do
          cursor = described
          cursor.show
          cursor.to_s.must_equal("\e[8;19H\e[?25h")
        end
      end

      context 'when the cursor state is :hide' do
         it 'returns an escape sequence for hiding the cursor (and position)' do
          cursor = described
          cursor.hide
          cursor.to_s.must_equal("\e[8;19H\e[?25l")
        end
      end

      it 'returns the escape sequence to position and set the visibility of ' \
         'the cursor' do
        described.to_s.must_equal("\e[8;19H\e[?25h")
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
