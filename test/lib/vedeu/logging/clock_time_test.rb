require 'test_helper'

module Vedeu

  module Logging

    describe ClockTime do

      describe '.clock_time' do
        subject { Vedeu.clock_time }

        context 'when Process::CLOCK_MONOTONIC is defined' do
          it { subject.must_be_instance_of(Float) }
        end

        # context 'when Process::CLOCK_MONOTONIC is not defined' do
        #   it { subject.must_be_instance_of(Time) }
        # end

        # @todo Add more tests.
      end

    end # ClockTime

  end # Logging

end # Vedeu
