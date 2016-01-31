# frozen_string_literal: true

require 'test_helper'

module Vedeu

  module DSL

    class ElementsTest

      include Vedeu::DSL::Elements

      attr_reader :model

      def initialize(model)
        @model = model
      end

    end # ElementsTest

    describe Elements do

      let(:described)          { Vedeu::DSL::Elements }
      let(:included_described) { Vedeu::DSL::ElementsTest }
      let(:included_instance)  { included_described.new(model) }
      let(:model)              {}

      describe '#centre' do
        let(:_value) {}
        let(:opts)   {
          {

          }
        }

        subject { included_instance.centre(_value, opts) }

        context 'when a model exists' do
        end

        context 'when a model does not exist' do
          it { proc { subject }.must_raise(Vedeu::Error::Fatal) }
        end
      end

      describe '#center' do
        it { included_instance.must_respond_to(:center) }
      end

      describe '#left' do
        let(:_value) {}
        let(:opts)   {
          {

          }
        }

        subject { included_instance.left(_value, opts) }

        context 'when a model exists' do
        end

        context 'when a model does not exist' do
          it { proc { subject }.must_raise(Vedeu::Error::Fatal) }
        end
      end

      describe '#right' do
        let(:_value) {}
        let(:opts)   {
          {

          }
        }

        subject { included_instance.right(_value, opts) }

        context 'when a model exists' do
        end

        context 'when a model does not exist' do
          it { proc { subject }.must_raise(Vedeu::Error::Fatal) }
        end
      end

      describe '#lines' do
        let(:opts) { {} }

        subject { included_instance.lines(opts) { } }

        context 'when the block is given' do
          context 'when a model exists' do
            let(:model) {}
          end

          context 'when a model does not exist' do
            it { proc { subject }.must_raise(Vedeu::Error::Fatal) }
          end
        end

        context 'when the block is not given' do
          subject { included_instance.lines }

          it { proc { subject }.must_raise(Vedeu::Error::RequiresBlock) }
        end

        context 'when the opts parameter is not given' do
          subject { included_instance.lines { } }

          # @todo Add more tests.
        end
      end

      describe '#line' do
        subject { included_instance.line { } }

        context 'when a model exists' do
          let(:model) { Vedeu::Views::View.new }

          context 'when the block is given' do
            # @todo Add more tests.
          end

          context 'when the block is not given' do
            subject { included_instance.line }

            # @todo Add more tests.
          end
        end

        context 'when a model does not exist' do
          it { proc { subject }.must_raise(Vedeu::Error::Fatal) }
        end
      end

      describe '#streams' do
        let(:opts) { {} }

        subject { included_instance.streams(opts) { } }

        context 'when the block is given' do
          context 'when a model exists' do
            let(:model) {}

            # @todo Add more tests.
          end

          context 'when a model does not exist' do
            it { proc { subject }.must_raise(Vedeu::Error::Fatal) }
          end
        end

        context 'when the block is not given' do
          subject { included_instance.streams }

          it { proc { subject }.must_raise(Vedeu::Error::RequiresBlock) }
        end

        context 'when the opts parameter is not given' do
          subject { included_instance.streams { } }

          # @todo Add more tests.
        end
      end

      describe '#stream' do
        subject { included_instance.stream { } }

        context 'when a model exists' do
          let(:model) { Vedeu::Views::View.new }

          context 'when the block is given' do
            # @todo Add more tests.
          end

          context 'when the block is not given' do
            subject { included_instance.stream }

            # @todo Add more tests.
          end
        end

        context 'when a model does not exist' do
          it { proc { subject }.must_raise(Vedeu::Error::Fatal) }
        end
      end

      describe '#text' do
        let(:_value) {}
        let(:opts)   {
          {

          }
        }

        subject { included_instance.text(_value, opts) }

        context 'when a model exists' do
        end

        context 'when a model does not exist' do
          it { proc { subject }.must_raise(Vedeu::Error::Fatal) }
        end
      end

    end # Elements

  end # DSL

end # Vedeu
