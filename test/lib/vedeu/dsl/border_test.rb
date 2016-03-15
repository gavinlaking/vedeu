# frozen_string_literal: true

require 'test_helper'

module Vedeu

  class DSLBorderTestClass

    include Vedeu::DSL::Border

    def model
      self
    end

    def name
      :vedeu_dsl_border_test_class
    end

  end # DSLBorderTestClass

  module DSL

    describe Border do

      let(:described) { Vedeu::DSL::Border }
      let(:included_described) { Vedeu::DSLBorderTestClass }
      let(:instance)  { included_described.new }
      let(:_name)     { :vedeu_dsl_border }

      describe '.included' do
        subject { described.included(included_described) }

        it { subject.must_be_instance_of(Class) }
      end

      describe '#border' do
        subject { instance.border(_name) {} }

        context 'when the block is not given' do
          subject { instance.border(_name) }

          it { proc { subject }.must_raise(Vedeu::Error::RequiresBlock) }
        end

        context 'when the block is given' do
          context 'when the name is not given' do
            let(:_name) {}

            it 'uses the name of the model' do
              subject.must_be_instance_of(Vedeu::Borders::Border)
              subject.name.must_equal(:vedeu_dsl_border_test_class)
            end
          end

          context 'when the name is given' do
            it 'uses the given name' do
              subject.must_be_instance_of(Vedeu::Borders::Border)
              subject.name.must_equal(:vedeu_dsl_border)
            end
          end
        end
      end

      describe '#border!' do
        subject { instance.border! }

        it 'builds and stores a default border' do
          subject.must_be_instance_of(Vedeu::Borders::Border)
        end
      end

    end # Border

  end # DSL

end # Vedeu
