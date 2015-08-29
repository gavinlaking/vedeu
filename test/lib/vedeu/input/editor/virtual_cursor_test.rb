require 'test_helper'

module Vedeu

  module Editor

    describe VirtualCursor do

      let(:described) { Vedeu::Editor::VirtualCursor }
      let(:instance)  {
        described.new(y:   y,
                      x:   x,
                      bx:  bx,
                      by:  by,
                      byn: byn,
                      bxn: bxn,
                      oy:  oy,
                      ox:  ox)
      }
      let(:y)         { 0 }
      let(:x)         { 0 }
      let(:by)        { 1 }
      let(:bx)        { 1 }
      let(:byn)       { 6 }
      let(:bxn)       { 6 }
      let(:oy)        { 0 }
      let(:ox)        { 0 }

      describe '#initialize' do
        it { instance.must_be_instance_of(described) }
        it { instance.instance_variable_get('@y').must_equal(y) }
        it { instance.instance_variable_get('@x').must_equal(x) }
        it { instance.instance_variable_get('@by').must_equal(by) }
        it { instance.instance_variable_get('@bx').must_equal(bx) }
        it { instance.instance_variable_get('@byn').must_equal(byn) }
        it { instance.instance_variable_get('@bxn').must_equal(bxn) }
        it { instance.instance_variable_get('@oy').must_equal(0) }
        it { instance.instance_variable_get('@ox').must_equal(0) }

        context 'when x is nil' do
          it { instance.instance_variable_get('@x').must_equal(0) }
        end

        context 'when x is not nil' do
          let(:x) { 3 }

          it { instance.instance_variable_get('@x').must_equal(3) }
        end

        context 'when y is nil' do
          it { instance.instance_variable_get('@y').must_equal(0) }
        end

        context 'when y is not nil' do
          let(:y) { 6 }

          it { instance.instance_variable_get('@y').must_equal(6) }
        end
      end

      describe '#accessors' do
        it { instance.must_respond_to(:bx) }
        it { instance.must_respond_to(:bx=) }
        it { instance.must_respond_to(:by) }
        it { instance.must_respond_to(:by=) }
        it { instance.must_respond_to(:bxn) }
        it { instance.must_respond_to(:bxn=) }
        it { instance.must_respond_to(:byn) }
        it { instance.must_respond_to(:byn=) }
        it { instance.must_respond_to(:ox) }
        it { instance.must_respond_to(:ox=) }
        it { instance.must_respond_to(:oy) }
        it { instance.must_respond_to(:oy=) }
        it { instance.must_respond_to(:x) }
        it { instance.must_respond_to(:x=) }
        it { instance.must_respond_to(:y) }
        it { instance.must_respond_to(:y=) }
      end

      describe '#bol' do
        let(:x)  { 11 }
        let(:ox) { 4 }

        subject { instance.bol }

        it { subject.must_be_instance_of(described) }

        it { subject.x.must_equal(0) }
        it { subject.ox.must_equal(0) }
      end

      describe '#down' do
        let(:y) { 11 }

        subject { instance.down }

        it { subject.must_be_instance_of(described) }

        it { subject.y.must_equal(12) }
      end

      describe '#left' do
        let(:x)  { 11 }
        let(:ox) { 4 }

        subject { instance.left }

        it { subject.must_be_instance_of(described) }

        it { subject.x.must_equal(10) }
        it { subject.ox.must_equal(3) }
      end

      describe '#reset!' do
        let(:x)  { 11 }
        let(:y)  { 5 }
        let(:ox) { 4 }
        let(:oy) { 2 }

        subject { instance.reset! }

        it { subject.must_be_instance_of(described) }
        it { subject.x.must_equal(0) }
        it { subject.y.must_equal(0) }
        it { subject.ox.must_equal(0) }
        it { subject.oy.must_equal(0) }
      end

      describe '#right' do
        let(:x) { 11 }

        subject { instance.right }

        it { subject.must_be_instance_of(described) }

        it { subject.x.must_equal(12) }
      end

      describe '#to_s' do
        let(:x) { 11 }
        let(:y) { 5 }

        subject { instance.to_s }

        it { subject.must_be_instance_of(String) }

        it { subject.must_equal("\e[6;6H\e[?25h") }
      end

      describe '#up' do
        let(:y)  { 11 }
        let(:oy) { 2 }

        subject { instance.up }

        it { subject.must_be_instance_of(described) }

        it { subject.y.must_equal(10) }
        it { subject.oy.must_equal(1) }
      end

      describe '#x' do
        subject { instance.x }

        it { subject.must_be_instance_of(Fixnum) }

        # @todo Add more tests.
        # it { skip }
      end

      describe '#y' do
        subject { instance.x }

        it { subject.must_be_instance_of(Fixnum) }

        # @todo Add more tests.
        # it { skip }
      end

    end # VirtualCursor

  end # Editor

end # Vedeu
