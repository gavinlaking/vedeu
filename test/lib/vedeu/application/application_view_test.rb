require 'test_helper'

module Vedeu

  describe ApplicationView do

    let(:described) { Vedeu::ApplicationView }
    let(:instance)  { described.new(object) }
    let(:object)    {}

    describe '#initialize' do
      subject { instance }

      it { subject.must_be_instance_of(Vedeu::ApplicationView) }
      it { subject.instance_variable_get('@object').must_equal(object) }
    end

    describe '.render' do
      it { described.must_respond_to(:render) }
    end

  end # ApplicationView

end # Vedeu
