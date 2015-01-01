require 'test_helper'

module Vedeu

  module DSL

    describe Style do

      describe '#style' do
        let(:model) { Vedeu::ModelTestClass.new({}) }

        subject { Vedeu::DSL::ModelTestClass.new(model) }

        context 'with no arguments' do
          it { return_type_for(subject.style, Vedeu::Style) }
        end

        context 'with one argument' do
          it { return_type_for(subject.style(:bold), Vedeu::Style) }
        end

        context 'with multiple arguments' do
          it { return_type_for(subject.style(:bold, :blink), Vedeu::Style) }
        end
      end

    end # Style

  end # DSL

end # Vedeu
