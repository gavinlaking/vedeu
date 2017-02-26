# frozen_string_literal: true

require 'test_helper'

module Vedeu

  describe 'Bindings' do
    it { Vedeu.bound?(:_refresh_cursor_).must_equal(true) }
  end

  module Cursors

    describe Refresh do

      let(:described) { Vedeu::Cursors::Refresh }
      let(:instance)  { described.new(_name) }
      let(:_name)     { :vedeu_cursors_refresh }
      let(:expected)  {}
      let(:cursor)    {
        Vedeu::Cursors::Cursor.store(name:    _name,
                                     ox:      ox,
                                     oy:      oy,
                                     visible: visible)
      }
      let(:ox)        { 0 }
      let(:oy)        { 0 }
      let(:visible)   { false }

      describe '#initialize' do
        it { instance.must_be_instance_of(described) }
        it { instance.instance_variable_get('@name').must_equal(_name) }
      end

      describe '.by_name' do
        before do
          Vedeu.stubs(:trigger).with(:_hide_cursor_)
          Vedeu.stubs(:trigger).with(:_show_cursor_)
          Vedeu.stubs(:trigger).with(:_refresh_view_content_, _name)
          Vedeu.stubs(:log)
          Vedeu.geometry(_name) do
            x  1
            xn 3
            y  1
            yn 3
          end
          Vedeu.cursors.stubs(:by_name).with(_name).returns(cursor)
          Vedeu::Terminal.stubs(:output).returns(expected)
        end

        subject { described.by_name(_name) }

        context 'when the cursor is visible' do
          let(:visible) { true }

          it 'renders the cursor in the terminal' do
            cursor.expects(:render)
            subject
          end

          context 'when the cursors offset position is outside the viewable area' do
            let(:ox) { 3 }
            let(:oy) { 3 }

            it 'refreshes the view' do
              Vedeu.expects(:trigger).with(:_refresh_view_content_, _name)
              subject
            end
          end

          context 'when the cursors offset position is inside the viewable area' do
            it 'does not refresh the view' do
              Vedeu.expects(:trigger).with(:_refresh_view_content_, _name).never
              subject
            end
          end
        end

        context 'when the cursor is not visible' do
          it { assert_nil(subject) }
        end
      end

      describe '#by_name' do
        it { instance.must_respond_to(:by_name) }
      end

    end # Refresh

  end # Cursors

end # Vedeu
