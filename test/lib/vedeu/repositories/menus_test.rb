require 'test_helper'

module Vedeu

  describe Menus do

    describe '.menus' do
      subject { Vedeu::Menus.menus }

      it { subject.must_be_instance_of(Vedeu::Menus) }
    end

  end # Menus

end # Vedeu
