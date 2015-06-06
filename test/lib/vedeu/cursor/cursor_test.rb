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
        visible:    visible,
        x:          x,
        y:          y,
      }
    }
    let(:_name)      { 'silver' }
    let(:ox)         { 3 }
    let(:oy)         { 2 }
    let(:repository) { Vedeu.cursors }
    let(:visible)    { true }
    let(:x)          { 19 }
    let(:y)          { 8 }

    describe '#initialize' do
      subject { instance }

      it { subject.must_be_instance_of(described) }
      it { subject.instance_variable_get('@name').must_equal('silver') }
      it { subject.instance_variable_get('@ox').must_equal(3) }
      it { subject.instance_variable_get('@oy').must_equal(2) }
      it { subject.instance_variable_get('@repository').must_equal(repository) }
      it { subject.instance_variable_get('@visible').must_equal(true) }
      it { subject.instance_variable_get('@x').must_equal(19) }
      it { subject.instance_variable_get('@y').must_equal(8) }
    end

    describe '#hide_cursor' do
      subject { instance.hide_cursor }

      it { subject.must_be_instance_of(Vedeu::EscapeChar) }
      it { subject.to_s.must_equal("\e[?25l") }
    end

    describe '#inspect' do
      subject { instance.inspect }

      it { subject.must_be_instance_of(String) }
      it { subject.must_equal(
        '<Vedeu::Cursor (silver, true, x:19, y:8, ox:3, oy:2)>'
      ) }
    end

    describe '#show_cursor' do
      subject { instance.show_cursor }

      it { subject.must_be_instance_of(Vedeu::EscapeChar) }
      it { subject.to_s.must_equal("\e[?25h") }
    end

    describe '#to_s' do
      let(:visible) { true }

      subject { instance.to_s }

      it { subject.must_be_instance_of(String) }

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

      context 'when a block is given' do
        subject {
          instance.to_s do
            # ...
          end
        }

        it 'returns the escape sequence to position and set the visibility ' \
           'of the cursor and returns to that position after yielding the '  \
           'block' do
          subject.must_equal("\e[8;19H\e[?25h\e[8;19H\e[?25h")
        end
      end
    end

  end # Cursor

end # Vedeu
