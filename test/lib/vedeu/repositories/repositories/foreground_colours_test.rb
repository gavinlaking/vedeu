require 'test_helper'

module Vedeu

  describe ForegroundColours do

    let(:described) { Vedeu::ForegroundColours }

    describe '.foreground_colours' do
      subject { described.foreground_colours }

      it { subject.must_be_instance_of(described) }
    end

  end # ForegroundColours

end # Vedeu
