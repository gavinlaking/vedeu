require 'test_helper'

module Vedeu

  module DSL

    describe Shared do

      let(:described) { Vedeu::DSL::Shared }
      let(:instance)  { Class.include(described).new }

      describe '#border' do
        context 'when the block is not given' do
          subject { instance.border }

          it { proc { subject }.must_raise(Vedeu::Error::RequiresBlock) }
        end
      end

      describe '#geometry' do
        context 'when the required block is not given' do
          subject { instance.geometry }

          it { proc { subject }.must_raise(Vedeu::Error::RequiresBlock) }
        end
      end

    end # Shared

  end # DSL

end # Vedeu
