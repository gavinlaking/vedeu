# frozen_string_literal: true

require 'test_helper'

module Vedeu

  module Repositories

    class ModelTestClass
    end # ModelTestClass

    class RegisterableTestClass

      include Vedeu::Repositories::Registerable

      null Vedeu::Repositories::ModelTestClass
      real Vedeu::Repositories::ModelTestClass

    end # RegisterableTestClass

    describe Registerable do

      let(:described)          { Vedeu::Repositories::Registerable }
      let(:included_described) { Vedeu::Repositories::RegisterableTestClass }

      it { included_described.must_respond_to(:repository) }
      it { included_described.must_respond_to(:register) }

      describe '.included' do
        subject { described.included(included_described) }

        it { subject.must_be_instance_of(Class) }
      end

      describe '.null' do
        subject { included_described.new }

        it { included_described.must_respond_to(:null) }

        it { subject.must_respond_to(:null_model) }
        it { subject.must_respond_to(:null_attributes) }
        it {
          subject.null_model.must_equal(Vedeu::Repositories::ModelTestClass)
        }
        it { subject.null_attributes.must_equal({}) }
      end

      describe '.real' do
        subject { included_described.new }

        it { included_described.must_respond_to(:real) }

        it { subject.must_respond_to(:model) }
        it { subject.model.must_equal(Vedeu::Repositories::ModelTestClass) }
      end

      describe '.reset' do
        subject { included_described.reset! }

        before { included_described.stubs(:register) }

        it { included_described.must_respond_to(:reset!) }
        it { included_described.must_respond_to(:reset) }

        it do
          included_described.expects(:register)
          subject
        end
      end

    end # Registerable

  end # Repositories

end # Vedeu
