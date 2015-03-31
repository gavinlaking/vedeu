require 'test_helper'

module Vedeu

  describe Buffers do

    let(:described) { Vedeu::Buffers }

    describe '.buffers' do
      subject { described.buffers }

      it { subject.must_be_instance_of(described) }
    end

  end # Buffers

end # Vedeu
