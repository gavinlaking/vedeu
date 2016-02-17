# frozen_string_literal: true

require 'test_helper'

module Vedeu

  module Error

    describe ActionNotFound do
    end # ActionNotFound

    describe ControllerNotFound do
    end # ControllerNotFound

    describe Fatal do
    end # Fatal

    describe Interrupt do
    end # Interrupt

    describe InvalidSyntax do
    end # InvalidSyntax

    describe MissingRequired do
    end # MissingRequired

    describe ModelNotFound do
    end # ModelNotFound

    describe ModeSwitch do
    end # ModeSwitch

    describe NotImplemented do

      let(:described) { Vedeu::Error::NotImplemented }
      let(:instance)  { described.new }

      describe '#message' do
        subject { instance.message }

        it { subject.must_be_instance_of(String) }
      end

    end # NotImplemented

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
