# frozen_string_literal: true

require 'test_helper'

module Vedeu

  module Colours

    describe Foregrounds do

      let(:described) { Vedeu::Colours::Foregrounds }

      describe '.foreground_colours' do
        subject { described.foreground_colours }

        it { subject.must_be_instance_of(described) }
      end

    end # Foregrounds

  end # Colours

end # Vedeu
