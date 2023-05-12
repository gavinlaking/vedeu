# frozen_string_literal: true

require 'test_helper'

module Vedeu

  module Cursors

    describe Move do

      let(:described) { Vedeu::Cursors::Move }
      let(:instance)  { described.new(_name, direction, offset) }
      let(:_name)     {}
      let(:direction) {}
      let(:offset)    { 1 }
      let(:visible)   { true }

      describe '#initialize' do
        it { instance.must_be_instance_of(described) }
        it { instance.instance_variable_get('@name').must_equal(_name) }
        it do
          instance.instance_variable_get('@direction').must_equal(direction)
        end
        it { instance.instance_variable_get('@offset').must_equal(offset) }
      end

      describe '.move' do
        let(:cursor) {
          Vedeu::Cursors::Cursor.new(name: _name, visible: visible)
        }

        before do
          Vedeu.stubs(:trigger).with(:_refresh_cursor_, _name)
        end

        subject { described.move(_name, direction, offset) }

        context 'when a name is given' do
          let(:_name) { :vedeu_cursors_move }

          before do
            Vedeu.cursors.stubs(:by_name).returns(cursor)
          end

          context 'when the cursor is visible' do
            context 'when a valid direction is given' do
              let(:direction) { :move_right }

              it { subject.must_be_instance_of(Vedeu::Cursors::Cursor) }
            end

            context 'when an invalid direction is given' do
              let(:direction) { :move_left }

              it { assert_nil(subject) }
            end
          end

          context 'when the cursor is not visible' do
            let(:visible) { false }

            it { assert_nil(subject) }
          end
        end

        context 'when a name is not given' do
          it { assert_nil(subject) }
        end
      end

      describe '#move' do
        it { instance.must_respond_to(:move) }
      end

    end # Move

  end # Cursors

end # Vedeu
