require 'test_helper'

module Vedeu

  module Error

    describe ActionNotFound do
    end

    describe ControllerNotFound do
    end

    describe Fatal do
    end

    describe Interrupt do
    end

    describe InvalidSyntax do
    end

    describe MissingRequired do
    end

    describe ModelNotFound do
    end

    describe ModeSwitch do
    end

    describe NotImplemented do
    end

    describe OutOfRange do

      let(:described) { Vedeu::Error::OutOfRange }
      let(:instance)  { described.new }

      describe '#message' do
        subject { instance.message }

        it { subject.must_be_instance_of(String) }
      end

    end # OutOfRange

    describe RequiresBlock do

      let(:described) { Vedeu::Error::RequiresBlock }
      let(:instance)  { described.new }

      describe '#message' do
        subject { instance.message }

        it { subject.must_be_instance_of(String) }
      end

    end # RequiresBlock

  end # Error

end # Vedeu
