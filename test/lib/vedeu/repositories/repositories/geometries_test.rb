require 'test_helper'

module Vedeu

  describe Geometries do

    let(:described) { Vedeu::Geometries }

    describe '.geometries' do
      subject { described.geometries }

      it { subject.must_be_instance_of(described) }
    end

  end # Geometries

end # Vedeu
