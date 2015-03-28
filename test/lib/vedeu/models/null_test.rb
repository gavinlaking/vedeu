require 'test_helper'

module Vedeu

  describe Null do

    let(:described) { Vedeu::Null }
    let(:instance)  { described.new }

    describe '#initialize' do
      it { instance.must_be_instance_of(Vedeu::Null) }
    end

    describe '#add' do
      subject { instance.add }

      it { subject.must_be_instance_of(NilClass) }
    end

    describe '#colour' do
      subject { instance.colour }

      it { subject.must_be_instance_of(NilClass) }
    end

    describe '#parent' do
      subject { instance.parent }

      it { subject.must_be_instance_of(NilClass) }
    end

    describe '#style' do
      subject { instance.style }

      it { subject.must_be_instance_of(NilClass) }
    end

  end # Null

end # Vedeu
