require 'test_helper'

module Vedeu

  module Repositories

    describe Registerable do

      class RegisterableTestClass

        include Vedeu::Repositories::Registerable

        null Vedeu::Repositories::ModelTestClass
        real Vedeu::Repositories::ModelTestClass

      end

      let(:described) { Vedeu::Repositories::Registerable }

      it { RegisterableTestClass.must_respond_to(:repository) }
      it { RegisterableTestClass.must_respond_to(:register) }

      describe '.null' do
        subject { RegisterableTestClass.new }

        it { RegisterableTestClass.must_respond_to(:null) }

        it { subject.must_respond_to(:null_model) }
        it { subject.must_respond_to(:null_attributes) }
        it { subject.null_model.must_equal(Vedeu::Repositories::ModelTestClass) }
        it { subject.null_attributes.must_equal({}) }
      end

      describe '.real' do
        subject { RegisterableTestClass.new }

        it { RegisterableTestClass.must_respond_to(:real) }

        it { subject.must_respond_to(:model) }
        it { subject.model.must_equal(Vedeu::Repositories::ModelTestClass) }
      end

      describe '.reset' do
        subject { RegisterableTestClass.reset! }

        before { RegisterableTestClass.stubs(:register) }

        it { RegisterableTestClass.must_respond_to(:reset!) }
        it { RegisterableTestClass.must_respond_to(:reset) }

        it do
          RegisterableTestClass.expects(:register)
          subject
        end
      end

    end # Registerable

  end # Repositories

end # Vedeu
