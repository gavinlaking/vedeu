require 'test_helper'

module Vedeu

  module Renderers

    class RenderersTestClass
      include Vedeu::Renderers::Options
    end

    describe Options do

      let(:described) { Vedeu::Renderers::Options }
      let(:instance) { RenderersTestClass.new }

      describe 'accessors' do
        it { instance.must_respond_to(:options=) }
      end

      # @todo Add more tests.
      # it { skip }

    end # Options

  end # Renderers

end # Vedeu
