require 'test_helper'

module Vedeu

  describe Foregrounds do

    let(:described) { Vedeu::Foregrounds }

    describe '.foreground_colours' do
      subject { described.foreground_colours }

      it { subject.must_be_instance_of(described) }
    end

  end # Foregrounds

end # Vedeu
