require 'test_helper'

module Vedeu

  describe Output do

    let(:described) { Output.new(interface) }
    let(:interface) {
      Vedeu.interface 'flourine' do
        geometry do
          height 3
          width  32
        end
      end
    }
    let(:lines) {
      [
        Line.new([Stream.new('this is the first')]),
        Line.new([Stream.new('this is the second and it is long')]),
        Line.new([Stream.new('this is the third, it is even longer and still truncated')]),
        Line.new([Stream.new('this should not render')]),
      ]
    }

    before do
      interface.lines = lines
      IO.console.stubs(:print)
    end

    describe '#initialize' do
      it { described.must_be_instance_of(Output) }
      it { described.instance_variable_get('@interface').must_equal(interface) }
    end

    describe '.render' do
      subject { Output.render(interface) }

      it { subject.must_be_instance_of(Array) }

      context 'when a border is defined for the interface' do
      end

      context 'when a border is not defined for the interface' do
      end
    end

  end # Output

end # Vedeu
