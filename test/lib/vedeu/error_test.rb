require 'test_helper'

module Vedeu

  module Error

    describe OutOfRange do

      let(:described) { Vedeu::Error::OutOfRange }
      let(:instance)  { described.new }

      describe '#message' do
        subject { instance.message }

        it { subject.must_be_instance_of(String) }
      end

    end # OutOfRange

  end # Error

end # Vedeu
