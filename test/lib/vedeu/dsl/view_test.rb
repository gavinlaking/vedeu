require 'test_helper'

module Vedeu

  module DSL

    describe View do

      let(:described) { Vedeu::DSL::View }

      describe '.renders' do
        subject {
          described.renders do
            # ...
          end
        }

        it { return_type_for(subject, Array) }

        context 'when the block is not given' do
          subject { described.renders }

          it { proc { subject }.must_raise(InvalidSyntax) }
        end
      end

      describe '.views' do
        subject {
          described.views do
            # ...
          end
        }

        it { return_type_for(subject, Array) }

        context 'when the block is not given' do
          subject { described.views }

          it { proc { subject }.must_raise(InvalidSyntax) }
        end
      end

    end # View

  end # DSL

end # Vedeu
