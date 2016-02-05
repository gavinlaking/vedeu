require 'test_helper'

module Vedeu

  module Renderers

    describe Escape do

      let(:described) { Vedeu::Renderers::Escape }
      let(:instance)  { described.new }

      describe '#clear' do
        let(:expected) { '[[:empty]]' }

        subject { instance.clear }

        it { subject.must_equal(expected) }
      end

    end # Escape

  end # Renderers

end # Vedeu
