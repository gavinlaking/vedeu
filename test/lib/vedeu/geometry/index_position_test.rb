require 'test_helper'

module Vedeu

  describe IndexPosition do

    let(:described) { Vedeu::IndexPosition }
    let(:instance)  { described.new(iy, ix, oy, ox) }
    let(:iy)        { 6 }
    let(:ix)        { 17 }
    let(:oy)        { 3 }
    let(:ox)        { 5 }

    describe 'alias methods' do
      it { instance.must_respond_to(:first) }
      it { instance.must_respond_to(:last) }
    end

    describe '#initialize' do
      it { instance.must_be_instance_of(described) }
      it { instance.instance_variable_get('@oy').must_equal(3) }
      it { instance.instance_variable_get('@ox').must_equal(5) }
      it { instance.instance_variable_get('@iy').must_equal(6) }
      it { instance.instance_variable_get('@ix').must_equal(17) }
    end

    describe '.[]' do
      subject { described[iy, ix] }

      it { subject.must_be_instance_of(Vedeu::Position) }
    end

    describe '#[]' do
      subject { instance.[] }

      it { subject.must_be_instance_of(Vedeu::Position) }
      it { subject.y.must_equal(9) }
      it { subject.x.must_equal(22) }
    end

    describe '#eql?' do
      let(:other) { described.new(8, 21) }

      subject { instance.eql?(other) }

      it { subject.must_equal(true) }

      context 'when different to other' do
        let(:other) { described.new(2, 9) }

        it { subject.must_equal(false) }
      end
    end

    describe '#y' do
      subject { instance.y }

      context 'when iy is <= 0' do
        let(:iy) { -2 }

        context 'and oy is <= 1' do
          let(:oy) { -6 }

          it { subject.must_equal(1) }
        end

        context 'and oy is > 1' do
          let(:oy) { 4 }

          it { subject.must_equal(4) }
        end
      end

      context 'when iy is > 0' do
        let(:iy) { 3 }

        context 'and oy is <= 1' do
          let(:oy) { -7 }

          it { subject.must_equal(4) }
        end

        context 'and oy is > 1' do
          let(:oy) { 5 }

          it { subject.must_equal(8) }
        end
      end
    end

    describe '#x' do
      subject { instance.x }

      context 'when ix is <= 0' do
        let(:ix) { -2 }

        context 'and ox is <= 1' do
          let(:ox) { -6 }

          it { subject.must_equal(1) }
        end

        context 'and ox is > 1' do
          let(:ox) { 4 }

          it { subject.must_equal(4) }
        end
      end

      context 'when ix is > 0' do
        let(:ix) { 3 }

        context 'and ox is <= 1' do
          let(:ox) { -7 }

          it { subject.must_equal(4) }
        end

        context 'and ox is > 1' do
          let(:ox) { 5 }

          it { subject.must_equal(8) }
        end
      end
    end

  end # IndexPosition

end # Vedeu
