require 'test_helper'

module Vedeu

  describe ApplicationView do

    let(:described) { Vedeu::ApplicationView }
    let(:instance)  { described.new(params) }
    let(:params)    { {} }

    describe '#initialize' do
      it { instance.must_be_instance_of(described) }
      it { instance.instance_variable_get('@params').must_equal(params) }
    end

    # describe 'accessors' do
    #   it { instance.must_respond_to(:params) }
    #   it { instance.must_respond_to(:params=) }
    # end

    describe '.render' do
      subject { described.render(params) }

      it { proc { subject }.must_raise(Vedeu::NotImplemented) }
    end

    describe '#render' do
      it { instance.must_respond_to(:render) }
    end

  end # ApplicationView

end # Vedeu
