require 'test_helper'

module Vedeu

  describe Renderer do

    let(:described) { Vedeu::Renderer }
    let(:instance)  { described.new(output) }
    let(:output)    {}

    describe '#initialize' do
      it { instance.must_be_instance_of(Vedeu::Renderer) }
      it { instance.instance_variable_get('@output').must_equal([output]) }
    end

    describe '.render' do
      subject { described.render }

      it { subject.must_be_instance_of(String) }
    end

  end # Renderer

end # Vedeu
