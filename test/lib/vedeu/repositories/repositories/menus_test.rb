require 'test_helper'

module Vedeu

  describe Menus do

    let(:described) { Vedeu::Menus }

    describe '.menus' do
      subject { described.menus }

      it { subject.must_be_instance_of(described) }
    end

  end # Menus

end # Vedeu
