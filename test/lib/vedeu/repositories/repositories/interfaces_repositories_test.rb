require 'test_helper'

module Vedeu

  describe InterfacesRepository do

    let(:described) { Vedeu::InterfacesRepository }

    describe '.interfaces' do
      subject { described.interfaces }

      it { subject.must_be_instance_of(described) }
    end

  end # InterfacesRepository

end # Vedeu
