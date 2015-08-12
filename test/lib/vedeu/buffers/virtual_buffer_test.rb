require 'test_helper'

module Vedeu

  describe VirtualBuffer do

    let(:described) { Vedeu::VirtualBuffer }
    let(:instance)  { described.new(height, width, renderer) }
    let(:height)    { 3 }
    let(:width)     { 3 }
    let(:renderer)  { Vedeu::Renderers::HTML.new }

    describe '#initialize' do
      it { instance.must_be_instance_of(described) }
      it { instance.instance_variable_get('@height').must_equal(3) }
      it { instance.instance_variable_get('@width').must_equal(3) }
      it { instance.instance_variable_get('@renderer').must_equal(renderer) }
    end

    describe 'accessors' do
      it { instance.must_respond_to(:renderer) }
      it { instance.must_respond_to(:renderer=) }
      it { instance.must_respond_to(:height) }
      it { instance.must_respond_to(:width) }
    end

    describe '.output' do
      let(:data) {}

      subject { described.output(data) }

      it { subject.must_be_instance_of(Array) }
    end

    describe '#cells' do
      subject { instance.cells }

      it { subject.must_be_instance_of(Array) }
      it { subject.size.must_equal(3) }
      it { subject.flatten.size.must_equal(9) }
    end

    describe '#read' do
      subject { instance.read(y, x) }

      context 'when x is out of bounds' do
        let(:y) { 1 }
        let(:x) { 5 }

        it { subject.must_equal([]) }
      end

      context 'when y is out of bounds' do
        let(:y) { 5 }
        let(:x) { 1 }

        it { subject.must_equal([]) }
      end

      context 'when both x and y are out of bounds' do
        let(:y) { 5 }
        let(:x) { 5 }

        it { subject.must_equal([]) }
      end

      context 'when x and y are in bounds' do
        let(:y) { 0 }
        let(:x) { 2 }

        it { subject.must_be_instance_of(Vedeu::Cell) }
      end
    end

    describe '#output' do
      it { instance.must_respond_to(:output) }
    end

    describe '#render' do
      subject { instance.render }

      it { subject.must_be_instance_of(String) }
    end

    describe '#reset' do
      subject { instance.reset }

      it { subject.must_be_instance_of(Array) }

      it { instance.must_respond_to(:clear) }
    end

    describe '#write' do
      let(:data) { Vedeu::Views::Char.new(value: 'a') }

      subject { instance.write(y, x, data) }

      context 'when x is out of bounds' do
        let(:y) { 1 }
        let(:x) { 5 }

        it { subject.must_equal(false) }
      end

      context 'when y is out of bounds' do
        let(:y) { 5 }
        let(:x) { 1 }

        it { subject.must_equal(false) }
      end

      context 'when both x and y are out of bounds' do
        let(:y) { 5 }
        let(:x) { 5 }

        it { subject.must_equal(false) }
      end

      context 'when x and y are in bounds' do
        let(:y) { 0 }
        let(:x) { 2 }

        it { subject.must_equal(true) }
      end
    end

  end # VirtualBuffer

end # Vedeu
