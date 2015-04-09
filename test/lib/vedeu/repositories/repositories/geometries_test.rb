require 'test_helper'

module Vedeu

  describe Geometries do

    let(:described) { Vedeu::Geometries }

    describe '.geometries' do
      subject { described.geometries }

      it { subject.must_be_instance_of(described) }
    end

    describe '#by_name' do
      let(:_name) { 'carbon' }

      subject { described.geometries.by_name(_name) }

      context 'when the geometry exists' do
        before do
          Vedeu.geometry 'carbon' do
            x  1
            xn 3
            y  1
            yn 3
          end
        end

        it { subject.must_be_instance_of(Vedeu::Geometry) }
      end

      context 'when the geometry does not exist' do
        let(:_name) { 'nitrogen' }

        it { subject.must_be_instance_of(Vedeu::NullGeometry) }
      end
    end

  end # Geometries

end # Vedeu
