require 'test_helper'

module Vedeu

  describe Bootstrap do

    let(:described) { Vedeu::Bootstrap }
    let(:instance)  { described.new(argv) }
    let(:argv)      { [] }

    describe '#initialize' do
      subject { instance }

      it { subject.must_be_instance_of(described) }
      it { subject.instance_variable_get('@argv').must_equal(argv) }
    end

    describe '.start' do
      it { described.must_respond_to(:start) }
    end

    describe '#start' do
      subject { instance.start }


    end

  end # Bootstrap

end # Vedeu
