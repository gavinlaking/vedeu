require 'test_helper'

module Vedeu

  module Renderers

    describe Text do

      let(:described) { Vedeu::Renderers::Text }
      let(:instance)  { described.new(output) }
      let(:output)    {}

      describe '#initialize' do
        it { instance.must_be_instance_of(described) }
        it { instance.instance_variable_get('@output').must_equal([output]) }
      end

      describe '.render' do
        subject { described.render }

        it { subject.must_be_instance_of(String) }
      end

    end # Text

  end # Renderers

end # Vedeu
