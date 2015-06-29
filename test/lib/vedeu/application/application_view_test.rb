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

  end # ApplicationView

end # Vedeu
