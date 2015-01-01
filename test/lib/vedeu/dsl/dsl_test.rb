require 'test_helper'

module Vedeu

  describe DSL do

    describe '.build' do
      let(:attributes) { {} }

      subject { ModelTestClass.build(attributes) { } }

      it { return_type_for(subject, ModelTestClass) }
    end

  end # DSL

end # Vedeu
