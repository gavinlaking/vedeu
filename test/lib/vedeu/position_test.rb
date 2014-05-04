require_relative '../../test_helper'

module Vedeu
  describe Position do
    let(:klass) { Position }
    let(:y)     { 67 }
    let(:x)     { 42 }

    subject { klass.[](y, x) }

    it { subject.must_be_instance_of(Vedeu::Position) }

    context 'when coordinates are provided' do
      it { subject.column.must_equal(42) }

      it { subject.row.must_equal(67) }

      it { subject.locate.must_equal([67, 42]) }
    end

    context 'when coordinates are not provided' do
      let(:y) {}
      let(:x) {}

      it { subject.column.must_equal(0) }

      it { subject.row.must_equal(0) }

      it { subject.locate.must_equal([0, 0]) }
    end
  end
end
