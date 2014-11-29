require 'test_helper'

module Vedeu

  describe Model do

    describe '#store' do
      let(:attributes) {
        {
          name: 'hydrogen'
        }
      }

      subject { ModelTestClass.new(attributes).store }

      it 'returns the model' do
        subject.must_be_instance_of(ModelTestClass)
      end
    end

  end # Model

end # Vedeu
