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

      let(:described) { Vedeu::DSL::Elements }
      let(:instance)  {}

      let(:including_described) { Vedeu::DSL::ElementsTest }
      let(:including_instance)  { including_described.new(model) }
      let(:model)               {}

      describe '#lines' do
        subject { including_instance.lines { } }

        context 'when the block is given' do
          context 'when a model exists' do
            let(:model) {}
          end

          context 'when a model does not exist' do
            it { proc { subject }.must_raise(Vedeu::Error::Fatal) }
          end
        end

        context 'when the block is not given' do
          subject { including_instance.lines }

          it { proc { subject }.must_raise(Vedeu::Error::RequiresBlock) }
        end
      end

      describe '#line' do
        subject { including_instance.line { } }

        context 'when a model exists' do
          let(:model) { Vedeu::Views::View.new }

          context 'when the block is given' do
            # @todo Add more tests.
          end

          context 'when the block is not given' do
            subject { including_instance.line }

            # @todo Add more tests.
          end
        end

        context 'when a model does not exist' do
          it { proc { subject }.must_raise(Vedeu::Error::Fatal) }
        end
      end

      describe '#streams' do
        subject { including_instance.streams { } }

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
          subject { including_instance.streams }

          it { proc { subject }.must_raise(Vedeu::Error::RequiresBlock) }
        end
      end

      describe '#stream' do
        subject { including_instance.stream { } }

        context 'when a model exists' do
          let(:model) { Vedeu::Views::View.new }

          context 'when the block is given' do
            # @todo Add more tests.
          end

          context 'when the block is not given' do
            subject { including_instance.stream }

            # @todo Add more tests.
          end
        end

        context 'when a model does not exist' do
          it { proc { subject }.must_raise(Vedeu::Error::Fatal) }
        end
      end

    end # Elements

  end # DSL

end # Vedeu
