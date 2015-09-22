require 'test_helper'

module Vedeu

  module Renderers

    describe Text do

      let(:described) { Vedeu::Renderers::Text }
      let(:instance)  { described.new(options) }
      let(:options)   { {} }
      let(:output)    {}

      describe '#initialize' do
        it { instance.must_be_instance_of(described) }
        it { instance.instance_variable_get('@options').must_equal(options) }
      end

      describe '#clear' do
        subject { instance.clear }

        it { subject.must_be_instance_of(String) }
        it { subject.must_equal('') }
      end

      describe '#render' do
        subject { instance.render(output) }

        it { subject.must_be_instance_of(String) }
      end

    end # Text

  end # Renderers

end # Vedeu
