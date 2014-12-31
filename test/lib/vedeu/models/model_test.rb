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
        return_type_for(subject, ModelTestClass)
      end
    end

  end # Model

end # Vedeu
