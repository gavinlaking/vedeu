require 'test_helper'

module Vedeu

  describe ApplicationView do

    let(:described) { Vedeu::ApplicationView }
    let(:instance)  { described.new(object) }
    let(:object)    {}

    describe '#initialize' do
      it { instance.must_be_instance_of(Vedeu::ApplicationView) }
      it { instance.instance_variable_get('@object').must_equal(object) }
    end

    describe '.render' do
      it { described.must_respond_to(:render) }
    end

  end # ApplicationView

end # Vedeu
