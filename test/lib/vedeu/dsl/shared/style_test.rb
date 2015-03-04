require 'test_helper'

module Vedeu

  module DSL

    describe Style do

      let(:described) { Vedeu::DSL::Style }
      let(:instance)  { Vedeu::DSL::ModelTestClass.new(model) }
      let(:model)     { Vedeu::ModelTestClass.new({}) }

      describe '#style' do
        let(:args)  { :bold }

        subject { instance.style(args) }

        it { subject.must_be_instance_of(Vedeu::Style) }
      end

    end # Style

  end # DSL

end # Vedeu
