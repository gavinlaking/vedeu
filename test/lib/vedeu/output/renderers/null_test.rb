require 'test_helper'

module Vedeu

  describe Renderers::Null do

    let(:described) { Vedeu::Renderers::Null }

    describe '.render' do
      let(:args) {}

      subject { described.render(*args) }

      it { subject.must_be_instance_of(NilClass) }
    end

  end # Renderers::Null

end # Vedeu
