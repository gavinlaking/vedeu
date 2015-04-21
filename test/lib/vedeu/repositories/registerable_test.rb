require 'test_helper'

module Vedeu

  describe Registerable do

    class RegisterableTestClass

      include Vedeu::Registerable

      null Vedeu::ModelTestClass

    end

    describe '.included' do
      it { RegisterableTestClass.must_respond_to(:null) }
    end

    describe '.null' do
      subject { RegisterableTestClass.new }

      it { subject.must_respond_to(:null_model) }
      it { subject.null_model.must_equal(Vedeu::ModelTestClass) }
    end

  end # Registerable

end # Vedeu
