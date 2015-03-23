require 'test_helper'

module Vedeu

  describe TerminalRenderer do

    let(:described) { Vedeu::TerminalRenderer }
    let(:instance)  { described.new(output) }
    let(:output)    {}

    describe '#initialize' do
      it { instance.must_be_instance_of(Vedeu::TerminalRenderer) }
      it { instance.instance_variable_get('@output').must_equal([output]) }
    end

    describe '.render' do
      subject { described.render }

      it { subject.must_be_instance_of(Array) }
    end

  end # TerminalRenderer

end # Vedeu
