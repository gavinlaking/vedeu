require 'test_helper'

module Vedeu

  module Colours

    describe Backgrounds do

      let(:described) { Vedeu::Colours::Backgrounds }

      describe '.background_colours' do
        subject { described.background_colours }

        it { subject.must_be_instance_of(described) }
      end

    end # Backgrounds

  end # Colours

end # Vedeu
