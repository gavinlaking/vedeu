require 'test_helper'

module Vedeu

  describe Keymaps do

    let(:described) { Vedeu::Keymaps }

    describe '.keymaps' do
      subject { described.keymaps }

      it { subject.must_be_instance_of(described) }
    end

  end # Keymaps

end # Vedeu
