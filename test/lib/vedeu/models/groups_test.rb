require 'test_helper'

module Vedeu

  module Models

    describe Groups do

      let(:described) { Vedeu::Models::Groups }

      it { described.must_respond_to(:groups) }

      describe '#by_name' do
        let(:_name) { 'carbon' }

        subject { described.groups.by_name(_name) }

        it { subject.must_be_instance_of(Vedeu::Models::Group) }
      end

    end # Groups

  end # Models

end # Vedeu
