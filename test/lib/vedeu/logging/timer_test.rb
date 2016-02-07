# frozen_string_literal: true

require 'test_helper'

module Vedeu

  module Logging

    describe Timer do

      let(:described) { Vedeu::Logging::Timer }
      let(:instance)  { described.new(_message) }
      let(:_message)  { 'Testing' }
      let(:_time)     { 1219.523818 }

      before do
        Vedeu.stubs(:clock_time).returns(_time)
      end

      describe '#initialize' do
        it { instance.must_be_instance_of(described) }
        it { instance.instance_variable_get('@message').must_equal(_message) }
        it { instance.instance_variable_get('@started').must_equal(_time) }
      end

      describe '.timer' do
        it { described.must_respond_to(:timer) }
      end

      describe '#measure' do
        context 'when the block is given' do
          subject { instance.measure { :thing_to_be_measured } }

          context 'when debugging is enabled' do
            before { Vedeu.config.stubs(:debug?).returns(true) }

            it do
              Vedeu.expects(:log)
                .with(type:    :timer,
                      message: "Testing took 0.0ms.")
              subject
            end
          end

          context 'when debugging is disabled' do
            before { Vedeu.config.stubs(:debug?).returns(false) }

            it { subject.must_equal(:thing_to_be_measured) }
          end
        end

        context 'when the block is not given' do
          subject { instance.measure }

          it { proc { subject }.must_raise(Vedeu::Error::RequiresBlock) }
        end
      end

    end # Timer

  end # Logging

end # Vedeu
