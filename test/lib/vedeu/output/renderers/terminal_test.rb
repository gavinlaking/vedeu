require 'test_helper'

module Vedeu

  module Renderers

    describe Terminal do

      let(:described) { Vedeu::Renderers::Terminal }
      let(:instance)  { described.new(options) }
      let(:options)   { {} }
      let(:output)    {}

      describe '#initialize' do
        it { instance.must_be_instance_of(described) }
        it { instance.instance_variable_get('@options').must_equal(options) }
      end

      describe '#render' do
        subject { instance.render(output) }

        it { subject.must_be_instance_of(Array) }
      end

    end # Terminal

  end # Renderers

end # Vedeu
