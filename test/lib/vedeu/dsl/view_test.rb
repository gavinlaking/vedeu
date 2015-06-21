require 'test_helper'

module Vedeu

  module DSL

    describe View do

      let(:described) { Vedeu::DSL::View }

      describe '.interface' do
        after { Vedeu.interfaces.reset }

        subject {
          described.interface('flourine') do
            # ...
          end
        }

        it { subject.must_be_instance_of(Vedeu::Interface) }

        context 'when the block is not given' do
          subject { described.interface }

          it { proc { subject }.must_raise(InvalidSyntax) }
        end

        context 'when the name was not set' do
          subject {
            described.interface('') do
              # ...
            end
          }

          it { proc { subject }.must_raise(MissingRequired) }
        end
      end

      describe '.renders' do
        subject {
          described.renders do
            # ...
          end
        }

        it { subject.must_be_instance_of(Array) }

        context 'when the block is not given' do
          subject { described.renders }

          it { proc { subject }.must_raise(InvalidSyntax) }
        end

        context 'when the block is given' do
          it { subject.must_equal([]) }
        end
      end

      describe '.views' do
        subject {
          described.views do
            # ...
          end
        }

        it { subject.must_be_instance_of(Array) }

        context 'when the block is not given' do
          subject { described.views }

          it { proc { subject }.must_raise(InvalidSyntax) }
        end

        context 'when the block is given' do
          it { subject.must_equal([]) }
        end
      end

    end # View

  end # DSL

end # Vedeu
