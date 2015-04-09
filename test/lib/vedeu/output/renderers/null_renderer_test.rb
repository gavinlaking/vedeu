require 'test_helper'

module Vedeu

  describe NullRenderer do

    let(:described) { Vedeu::NullRenderer }

    describe '.render' do
      let(:args) {}

      subject { described.render(*args) }

      it { subject.must_be_instance_of(NilClass) }
    end

  end # NullRenderer

end # Vedeu
