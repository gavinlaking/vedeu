require 'test_helper'

module Vedeu

  describe VirtualTerminal do

    let(:described) { Vedeu::VirtualTerminal }
    let(:instance)  { described.new(height, width) }
    let(:height)    { 25 }
    let(:width)     { 40 }

    describe '#initialize' do
      it { instance.must_be_instance_of(Vedeu::VirtualTerminal) }
      it { instance.instance_variable_get('@height').must_equal(height) }
      it { instance.instance_variable_get('@width').must_equal(width) }
    end

    describe '#cells' do
      subject { instance.cells }

      it { subject.must_be_instance_of(Array) }
    end

    describe '#height' do
      subject { instance.height }

      it { subject.must_equal(24) }
    end

    describe '#read' do
      subject { instance.read(y, x) }
    end

    describe '#width' do
      subject { instance.width }

      it { subject.must_equal(39) }
    end

    describe '#write' do
      subject { instance.write(y, x, data) }
    end

  end # VirtualTerminal

end # Vedeu
