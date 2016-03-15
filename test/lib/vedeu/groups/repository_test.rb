# frozen_string_literal: true

require 'test_helper'

module Vedeu

  module Groups

    describe Repository do

      let(:described) { Vedeu::Groups::Repository }

      describe '#by_name' do
        let(:_name) { 'carbon' }

        subject { described.groups.by_name(_name) }

        it { subject.must_be_instance_of(Vedeu::Groups::Group) }
      end

    end # Repository

  end # Groups

end # Vedeu
