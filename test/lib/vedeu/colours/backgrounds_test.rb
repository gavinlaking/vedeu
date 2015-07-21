require 'test_helper'

module Vedeu

  describe Backgrounds do

    let(:described) { Vedeu::Backgrounds }

    describe '.background_colours' do
      subject { described.background_colours }

      it { subject.must_be_instance_of(described) }
    end

  end # Backgrounds

end # Vedeu
