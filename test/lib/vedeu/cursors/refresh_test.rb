require 'test_helper'

module Vedeu

  module Cursors

    describe Refresh do

      let(:described) { Vedeu::Cursors::Refresh }
      let(:instance)  { described.new(_name) }
      let(:_name)     { 'refresh_cursor' }
      let(:expected)  {}
      let(:ox)        { 0 }
      let(:oy)        { 0 }

      describe '#initialize' do
        it { instance.must_be_instance_of(described) }
        it { instance.instance_variable_get('@name').must_equal(_name) }
      end

      describe '.by_name' do
        before do
          Vedeu.geometry 'refresh_cursor' do
            x  1
            xn 3
            y  1
            yn 3
          end
          Vedeu::Cursors::Cursor.new(name: 'refresh_cursor',
                                     ox:   ox,
                                     oy:   oy).store

          Vedeu::Terminal.stubs(:output).returns(expected)

          Vedeu.stubs(:trigger)
        end

        subject { described.by_name(_name) }

        it 'renders the cursor in the terminal' do
          Vedeu::Terminal.expects(:output).with("\e[1;1H\e[?25l")
          subject
        end

        context 'when the cursors offset position is outside the viewable area' do
          let(:ox) { 3 }
          let(:oy) { 3 }

          it 'refreshes the view' do
            Vedeu.expects(:trigger).with(:_refresh_view_, _name)
            subject
          end
        end

        context 'when the cursors offset position is inside the viewable area' do
          it 'does not refresh the view' do
            Vedeu.expects(:trigger).with(:_refresh_view_, _name).never
            subject
          end
        end
      end

      describe '#by_name' do
        it { instance.must_respond_to(:by_name) }
      end

    end # Refresh

  end # Cursors

end # Vedeu
