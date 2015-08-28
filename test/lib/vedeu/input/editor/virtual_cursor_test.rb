require 'test_helper'

module Vedeu

  module Editor

    describe VirtualCursor do

      let(:described) { Vedeu::Editor::VirtualCursor }
      let(:instance)  { described.new(y: y, x: x) }
      let(:y)         { 0 }
      let(:x)         { 0 }

      describe '#initialize' do
        it { instance.must_be_instance_of(described) }
        it { instance.instance_variable_get('@y').must_equal(y) }
        it { instance.instance_variable_get('@x').must_equal(x) }

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

      describe '#bol' do
        let(:x) { 11 }

        subject { instance.bol }

        it { subject.must_equal(0) }
      end

      describe '#down' do
        let(:y) { 11 }

        subject { instance.down }

        it { subject.must_equal(12) }
      end

      describe '#left' do
        let(:x) { 11 }

        subject { instance.left }

        it { subject.must_equal(10) }
      end

      describe '#right' do
        let(:x) { 11 }

        subject { instance.right }

        it { subject.must_equal(12) }
      end

      describe '#up' do
        let(:y) { 11 }

        subject { instance.up }

        it { subject.must_equal(10) }
      end

    end # VirtualCursor

  end # Editor

end # Vedeu
