# frozen_string_literal: true

require 'test_helper'

module Vedeu

  module Logging

    describe MonoLogger do

      let(:described) { Vedeu::Logging::MonoLogger }
      let(:instance)  { described.new(logdev) }
      let(:logdev)    {}

      describe '#initialize' do
        it { instance.must_be_instance_of(described) }
        it do
          instance.instance_variable_get('@level').must_equal(Logger::DEBUG)
        end
        it do
          instance.instance_variable_get('@default_formatter').
            must_be_instance_of(::Logger::Formatter)
        end
        it { assert_nil(instance.instance_variable_get('@Formatter')) }

        context 'when a log device is given' do
          # it do
          #   instance.instance_variable_get('@logdev').
          #     must_be_instance_of(Vedeu::Logging::LocklessLogDevice)
          # end
        end

        context 'when a log device is not given' do
          # it do
          #   instance.instance_variable_get('@logdev').
          #     must_be_instance_of(Vedeu::Logging::LocklessLogDevice)
          # end
        end
      end

    end # MonoLogger

  end # Logging

end # Vedeu
