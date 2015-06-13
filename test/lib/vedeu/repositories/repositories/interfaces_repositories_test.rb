require 'test_helper'

module Vedeu

  describe InterfacesRepository do

    let(:described) { Vedeu::InterfacesRepository }

    describe '.zindexed' do
      before do
        @hydrogen = Vedeu.interface 'hydrogen' do
          zindex 2
        end
        @helium = Vedeu.interface 'helium' do
          zindex 3
        end
        @lithium = Vedeu.interface 'lithium' do
          zindex 1
        end
      end
      after { Vedeu.interfaces.reset }

      subject { described.zindexed }

      it { subject.must_equal([@lithium, @hydrogen, @helium]) }
    end

  end # InterfacesRepository

end # Vedeu
