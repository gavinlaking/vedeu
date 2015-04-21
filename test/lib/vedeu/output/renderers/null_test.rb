require 'test_helper'

module Vedeu

  module Renderers

    describe Null do

      let(:described) { Vedeu::Renderers::Null }

      describe '.render' do
        let(:args) {}

        subject { described.render(*args) }

        it { subject.must_be_instance_of(NilClass) }
      end

    end # Null

  end # Renderers

end # Vedeu
