require 'test_helper'

module Vedeu

  describe Groups do

    let(:described) { Vedeu::Groups }

    it { described.must_respond_to(:groups) }

    describe '#by_name' do
      let(:_name) { 'carbon' }

      subject { described.groups.by_name(_name) }

      it { subject.must_be_instance_of(Vedeu::Group) }
    end

  end # Groups

end # Vedeu
