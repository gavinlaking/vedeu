require 'test_helper'

module Vedeu

  class FakeRenderer; end

  describe VirtualTerminal do

    let(:described) { Vedeu::VirtualTerminal }
    let(:instance)  { described.new(height, width, renderer) }
    let(:height)    { 5 }
    let(:width)     { 10 }
    let(:renderer)  { Vedeu::HTMLRenderer }

    describe '#initialize' do
      it { instance.must_be_instance_of(Vedeu::VirtualTerminal) }
      it { instance.instance_variable_get('@cell_height').must_equal(4) }
      it { instance.instance_variable_get('@cell_width').must_equal(9) }
      it { instance.instance_variable_get('@height').must_equal(5) }
      it { instance.instance_variable_get('@width').must_equal(10) }
      it { instance.instance_variable_get('@renderer').must_equal(Vedeu::HTMLRenderer) }
    end

    describe 'attr_accessor' do
      context '#renderer' do
        subject { instance.renderer }

        it { subject.must_equal(Vedeu::HTMLRenderer) }
      end
      context '#renderer=' do
        subject { instance.renderer=(Vedeu::FakeRenderer) }

        it { subject.must_equal(Vedeu::FakeRenderer) }
      end
    end
    describe 'attr_reader' do
      context '#cell_height' do
        subject { instance.cell_height }

        it { subject.must_equal(4) }
      end

      context '#cell_width' do
        subject { instance.cell_width }

        it { subject.must_equal(9) }
      end

      context '#height' do
        subject { instance.height }

        it { subject.must_equal(5) }
      end

      context '#width' do
        subject { instance.width }

        it { subject.must_equal(10) }
      end
    end

    describe '#cells' do
      subject { instance.cells }

      it { subject.must_be_instance_of(Array) }
    end

    describe '#read' do
      subject { instance.read(y, x) }

      context 'when x is out of bounds' do
        let(:y) { 3 }
        let(:x) { 15 }

        it { subject.must_equal([]) }
      end

      context 'when y is out of bounds' do
        let(:y) { 15 }
        let(:x) { 5 }

        it { subject.must_equal([]) }
      end

      context 'when both x and y are out of bounds' do
        let(:y) { 15 }
        let(:x) { 15 }

        it { subject.must_equal([]) }
      end

      context 'when x and y are in bounds' do
        let(:y) { 3 }
        let(:x) { 5 }

        it { subject.must_be_instance_of(Vedeu::Char) }
      end
    end

    describe '#output' do
      let(:data) {}

      subject { instance.output(data) }

      it { subject.must_be_instance_of(Array) }
    end

    describe '#reset' do
      subject { instance.reset }

      it { subject.must_be_instance_of(Array) }
    end

    describe '#write' do
      let(:data) { Vedeu::Char.new({ value: 'a' }) }

      subject { instance.write(y, x, data) }

      context 'when x is out of bounds' do
        let(:y) { 3 }
        let(:x) { 15 }

        it { subject.must_equal(false) }
      end

      context 'when y is out of bounds' do
        let(:y) { 15 }
        let(:x) { 5 }

        it { subject.must_equal(false) }
      end

      context 'when both x and y are out of bounds' do
        let(:y) { 15 }
        let(:x) { 15 }

        it { subject.must_equal(false) }
      end

      context 'when x and y are in bounds' do
        let(:y) { 3 }
        let(:x) { 5 }

        it { subject.must_equal(true) }
      end
    end

  end # VirtualTerminal

end # Vedeu
