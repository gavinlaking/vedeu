# frozen_string_literal: true

require 'test_helper'

module Vedeu

  module DSL

    describe Views do

      let(:described) { Vedeu::DSL::Views }
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

        it { subject.must_be_instance_of(Vedeu::Views::Composition) }

        context 'when the block is not given' do
          subject { described.renders }

          it { proc { subject }.must_raise(Vedeu::Error::RequiresBlock) }
        end

        context 'when the block is given' do
          context 'but no views were defined' do
            it { subject.views?.must_equal(false) }
          end
        end
      end

      describe '.views' do
        subject {
          described.views do
            # ...
          end
        }

        it { subject.must_be_instance_of(Vedeu::Views::Composition) }

        context 'when the block is not given' do
          subject { described.views }

          it { proc { subject }.must_raise(Vedeu::Error::RequiresBlock) }
        end

        context 'when the block is given' do
          context 'but no views were defined' do
            it { subject.views?.must_equal(false) }
          end
        end
      end

    end # Views

  end # DSL

end # Vedeu
