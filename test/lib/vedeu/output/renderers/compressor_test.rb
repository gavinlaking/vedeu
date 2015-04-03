require 'test_helper'

module Vedeu

  describe Compressor do

    let(:described) { Vedeu::Compressor }
    let(:instance)  { described.new(output) }
    let(:output)    {}

    describe '#initialize' do
      it { instance.must_be_instance_of(Vedeu::Compressor) }
      it { instance.instance_variable_get('@output').must_equal(output) }
    end

    describe '#render' do
      subject { instance.render }

      it { subject.must_be_instance_of(String) }
    end

  end # Compressor

end # Vedeu
