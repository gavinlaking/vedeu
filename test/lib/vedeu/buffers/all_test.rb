require 'test_helper'

module Vedeu

  describe '.buffers' do
    subject { Vedeu.buffers }

    it { subject.must_be_instance_of(Vedeu::Repository) }
  end

end # Vedeu
