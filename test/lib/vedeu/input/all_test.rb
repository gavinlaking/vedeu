require 'test_helper'

module Vedeu

  describe '.keymaps' do
    subject { Vedeu.keymaps }

    it { subject.must_be_instance_of(Vedeu::Repository) }
  end

end # Vedeu
