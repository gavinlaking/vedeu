# frozen_string_literal: true

require 'test_helper'

module Vedeu

  module Interfaces

    describe Repository do

      let(:described) { Vedeu::Interfaces::Repository }

      describe '#zindexed' do
        before do
          Vedeu.interfaces.reset

          @hydrogen = Vedeu.interface('hydrogen') do
            zindex 2
          end
          @helium = Vedeu.interface('helium') do
            zindex 3
          end
          @lithium = Vedeu.interface('lithium') do
            zindex 1
          end
        end
        after { Vedeu.interfaces.reset }

        subject { Vedeu.interfaces.zindexed }

        it { subject.must_equal(['lithium', 'hydrogen', 'helium']) }
      end

    end # Repository

  end # Interfaces

end # Vedeu
