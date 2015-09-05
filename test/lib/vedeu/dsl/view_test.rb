require 'test_helper'

module Vedeu

  module DSL

    describe View do

      let(:described) { Vedeu::DSL::View }
      let(:instance)  { described.new(model, client) }
      let(:model)     {
        Vedeu::Views::View.new(name: 'actinium')
      }
      let(:client) {}

      describe '.renders' do
        subject {
          described.renders do
            # ...
          end
        }

        it { described.must_respond_to(:render) }
        it { subject.must_be_instance_of(Array) }

        context 'when the block is not given' do
          subject { described.renders }

          it { proc { subject }.must_raise(Vedeu::Error::InvalidSyntax) }
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

          it { proc { subject }.must_raise(Vedeu::Error::InvalidSyntax) }
        end

        context 'when the block is given' do
          it { subject.must_equal([]) }
        end
      end

      describe '#lines' do
        subject {
          instance.lines do
            # ...
          end
        }

        it { subject.must_be_instance_of(Vedeu::Views::Lines) }

        context 'when the required block is not provided' do
          subject { instance.lines }

          it { proc { subject }.must_raise(Vedeu::Error::InvalidSyntax) }
        end

        it { instance.must_respond_to(:line) }
      end

    end # View

  end # DSL

end # Vedeu
