require 'test_helper'

module Vedeu

  module Renderers

    describe Null do

      let(:described) { Vedeu::Renderers::Null }
      let(:instance)  { described.new(options) }
      let(:options)   { {} }
      let(:output)    {}

      describe '#initialize' do
        it { instance.must_be_instance_of(Vedeu::Renderers::Null) }
        it { instance.instance_variable_get('@options').must_equal(options) }
      end

      describe '#clear' do
        subject { instance.clear }

        it { subject.must_be_instance_of(String) }
        it { subject.must_equal('') }
      end

      describe '#render' do
        subject { instance.render(output) }

        it { subject.must_be_instance_of(NilClass) }
      end

    end # Null

  end # Renderers

end # Vedeu
