require 'test_helper'

module Vedeu

  module DSL

    describe Style do

      describe '#style' do
        let(:model) { Vedeu::ModelTestClass.new({}) }
        let(:args)  { :bold }

        subject { Vedeu::DSL::ModelTestClass.new(model).style(args) }

        it { return_type_for(subject, Vedeu::Style) }
      end

    end # Style

  end # DSL

end # Vedeu
