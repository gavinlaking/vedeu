require 'test_helper'

module Vedeu

  describe Borders do

    let(:described) { Vedeu::Borders }

    describe '.borders' do
      subject { described.borders }

      it { subject.must_be_instance_of(described) }
    end

  end # Borders

  describe Geometries do

    let(:described) { Vedeu::Geometries }

    describe '.geometries' do
      subject { described.geometries }

      it { subject.must_be_instance_of(described) }
    end

  end # Geometries

  describe Menus do

    let(:described) { Vedeu::Menus }

    describe '.menus' do
      subject { described.menus }

      it { subject.must_be_instance_of(described) }
    end

  end # Menus

end # Vedeu
