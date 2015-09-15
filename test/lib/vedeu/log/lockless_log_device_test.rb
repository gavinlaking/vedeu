require 'test_helper'

module Vedeu

  module Logging

    describe LocklessLogDevice do

      let(:described)        { Vedeu::Logging::LocklessLogDevice }
      let(:instance)         { described.new(file_or_filename) }
      let(:file_or_filename) {}

      describe '#initialize' do
        # it { instance.must_be_instance_of(described) }
        # it {
        #   instance.instance_variable_get('@file_or_filename').
        #     must_equal(file_or_filename)
        # }

        # @todo Add more tests.
        # it { skip }
      end

      describe '#write' do
        subject { instance.write(message) }

        # @todo Add more tests.
        # it { skip }
      end

      describe '#close' do
        subject { instance.close }

        # @todo Add more tests.
        # it { skip }
      end

    end # LocklessLogDevice

  end # Loggings

end # Vedeu
