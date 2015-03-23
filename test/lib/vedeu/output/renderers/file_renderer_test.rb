require 'test_helper'

module Vedeu

  describe FileRenderer do

    let(:described) { Vedeu::FileRenderer }
    let(:instance)  { described.new(output) }
    let(:output)    {}

    describe '#initialize' do
      it { instance.must_be_instance_of(Vedeu::FileRenderer) }
      it { instance.instance_variable_get('@output').must_equal([output]) }
    end

    describe '.render' do
      subject { described.render }

      # it { subject.must_be_instance_of(String) }
    end

  end # FileRenderer

end # Vedeu
