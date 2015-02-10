require 'test_helper'

module Vedeu

  describe '.events' do
    subject { Vedeu.events }

    it { subject.must_be_instance_of(Vedeu::Repository) }
  end

end # Vedeu
