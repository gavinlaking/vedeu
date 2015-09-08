require 'test_helper'

module Vedeu

  describe ApplicationView do

    let(:described) { Vedeu::ApplicationView }
    let(:instance)  { described.new(params) }
    let(:params)    { {} }

    describe '#initialize' do
      it { instance.must_be_instance_of(described) }
      it { instance.instance_variable_get('@params').must_equal(params) }

      context 'defined methods' do
        let(:params) {
          {
            elements: [:hydrogen, :helium]
          }
        }

        it { instance.must_respond_to(:elements) }
        it { instance.elements.must_equal(params[:elements]) }

        context 'but the params contain a key already defined as a method' do
          let(:params) {
            {
              render: [:some_value]
            }
          }

          it { instance.must_respond_to(:render) }
          it { proc { instance.render }.wont_equal(params[:render]) }
        end
      end
    end

    # describe 'accessors' do
    #   it { instance.must_respond_to(:params) }
    #   it { instance.must_respond_to(:params=) }
    # end

    describe '.render' do
      subject { described.render(params) }

      it { proc { subject }.must_raise(Vedeu::Error::NotImplemented) }
    end

    describe '#render' do
      it { instance.must_respond_to(:render) }
    end

  end # ApplicationView

end # Vedeu
