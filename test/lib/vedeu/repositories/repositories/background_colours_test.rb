require 'test_helper'

module Vedeu

  describe BackgroundColours do

    let(:described) { Vedeu::BackgroundColours }

    describe '.background_colours' do
      subject { described.background_colours }

      it { subject.must_be_instance_of(described) }
    end

  end # BackgroundColours

end # Vedeu
