require 'test_helper'

module Vedeu

  module Cursors

    describe Reposition do

      let(:described)  { Vedeu::Cursors::Reposition }
      let(:instance)   { described.new(attributes) }
      let(:mode)       {}
      let(:_name)      { :reposition_test }
      let(:x)          { 0 }
      let(:y)          { 0 }
      let(:attributes) {
        {
          mode: mode,
          name: _name,
          x:    x,
          y:    y,
        }
      }

      before {
        Vedeu.interface :reposition_test do
          geometry do
            x  4
            y  4
            xn 13
            yn 9
          end
        end
        Vedeu.stubs(:trigger).with(:_refresh_cursor_, _name)
      }
      after { Vedeu.interfaces.reset! }

      describe '#initialize' do
        it { instance.must_be_instance_of(described) }
        it { instance.instance_variable_get('@mode').must_equal(mode) }
        it { instance.instance_variable_get('@name').must_equal(_name) }
        it { instance.instance_variable_get('@x').must_equal(x) }
        it { instance.instance_variable_get('@y').must_equal(y) }
      end

      describe '#reposition' do
        # let(:new_attributes) {
        #   {
        #     name: :reposition_test,
        #     ox:   0,
        #     oy:   0,
        #     repository: Vedeu.cursors,
        #     visible: false,
        #     x: 4,
        #     y: 4,
        #   }
        # }

        subject { instance.reposition }

        # it {
        #   subject
        #   Vedeu::Cursors::Cursor.expects(:store).with(new_attributes)
        #   Vedeu.expects(:trigger).with(:_refresh_cursor_, _name)
        # }

        it { subject.must_be_instance_of(Vedeu::Cursors::Cursor) }

        context 'when the mode is absolute' do
          let(:mode) { :absolute }

          context 'when inside the interface boundary' do
            let(:x) { 11 }
            let(:y) { 7 }

            it { subject.x.must_equal(11) }
            it { subject.y.must_equal(7) }
          end

          context 'when not inside the interface boundary' do
            let(:x) { 15 }
            let(:y) { 8 }

            it { subject.x.must_equal(4) }
            it { subject.y.must_equal(4) }
          end
        end

        context 'when the mode is relative' do
          let(:mode) { :relative }

          context 'when inside the interface boundary' do
            let(:x) { 7 }
            let(:y) { 7 }

            it { subject.x.must_equal(11) }
            it { subject.y.must_equal(9) }
          end

          context 'when not inside the interface boundary' do
            let(:x) { 2 }
            let(:y) { 8 }

            it { subject.x.must_equal(6) }
            it { subject.y.must_equal(9) }
          end
        end
      end

    end # Reposition

  end # Cursors

end # Vedeu
