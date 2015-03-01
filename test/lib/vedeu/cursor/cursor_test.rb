require 'test_helper'
require 'vedeu/cursor/cursor'

module Vedeu

  describe Cursor do

    let(:described)   { Vedeu::Cursor }
    let(:instance)    { described.new(attributes) }
    let(:attributes)  {
      {
        name:       _name,
        ox:         ox,
        oy:         oy,
        repository: repository,
        state:      state,
        x:          x,
        y:          y,
      }
    }
    let(:_name)      { 'silver' }
    let(:ox)         { 3 }
    let(:oy)         { 2 }
    let(:repository) { Vedeu.cursors }
    let(:state)      { :show }
    let(:x)          { 19 }
    let(:y)          { 8 }

    describe '#initialize' do
      it { instance.must_be_instance_of(Cursor) }
      it { instance.instance_variable_get('@name').must_equal('silver') }
      it { instance.instance_variable_get('@ox').must_equal(3) }
      it { instance.instance_variable_get('@oy').must_equal(2) }
      it { instance.instance_variable_get('@repository').must_equal(Vedeu.cursors) }
      it { instance.instance_variable_get('@state').must_be_instance_of(Vedeu::Visible) }
      it { instance.instance_variable_get('@x').must_equal(19) }
      it { instance.instance_variable_get('@y').must_equal(8) }

      it { instance.instance_variable_get('@position').must_be_instance_of(Vedeu::Position) }
    end

    describe '#to_s' do
      let(:state) { true }

      subject { instance.to_s }

      it { subject.must_be_instance_of(String) }

      context 'when the cursor is visible' do
        it 'returns an visible cursor escape sequence with position' do
          subject.must_equal("\e[8;19H\e[?25h")
        end
      end

      context 'when the cursor is invisible' do
        let(:state) { false }

        it 'returns the invisible cursor escape sequence with position' do
          subject.must_equal("\e[8;19H\e[?25l")
        end
      end

      context 'when a block is given' do
        subject {
          instance.to_s do
            # ...
          end
        }

        it 'returns the escape sequence to position and set the visibility of ' \
           'the cursor and returns to that position after yielding the block' do
          subject.must_equal("\e[8;19H\e[?25h\e[8;19H\e[?25h")
        end
      end
    end

  end # Cursor

end # Vedeu
