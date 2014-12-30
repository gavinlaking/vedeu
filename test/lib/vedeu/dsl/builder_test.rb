require 'test_helper'

module Vedeu

  module DSL

    describe Builder do

      let(:described) { Vedeu::DSL::Builder.new }

      describe '#initialize' do
        it { return_type_for(described, Vedeu::DSL::Builder) }
      end

      describe '.build' do
        context 'when the block is given' do
          subject {
            Vedeu::DSL::Builder.build do
              # ...
            end
          }
        end

        context 'when the block is not given' do
          subject { Vedeu::DSL::Builder.build }

          it { proc { subject }.must_raise(InvalidSyntax) }
        end
      end

    end # Builder

  end # DSL

end # Vedeu
