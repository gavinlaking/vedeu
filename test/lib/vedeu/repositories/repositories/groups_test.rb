require 'test_helper'

module Vedeu

  describe Groups do

    let(:described) { Vedeu::Groups }

    describe '.groups' do
      subject { described.groups }

      it { subject.must_be_instance_of(described) }
    end

  end # Groups

end # Vedeu
