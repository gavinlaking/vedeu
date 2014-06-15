require_relative '../../../test_helper'

module Vedeu
  describe Interface do
    let(:described_class)    { Interface }
    let(:described_instance) { described_class.new(attributes) }
    let(:subject)            { described_instance }
    let(:attributes)         {
      {
        name:   'dummy',
        width:  80,
        height: 25,
        x:      1,
        y:      1,
        fg:     :red,
        bg:     :blue
      }
    }
    let(:result)             {}

    before do
    end

    it { subject.must_be_instance_of(Interface) }
    it { subject.instance_variable_get("@attributes").must_equal(attributes) }
    it { subject.instance_variable_get("@active").must_equal(false) }
    it { subject.instance_variable_get("@name").must_equal('dummy') }

    describe '#create' do
      let(:subject) { described_class.create(attributes) }

      it { subject.must_be_instance_of(Interface) }
    end

    describe '#initial_state' do
      let(:subject) { described_instance.initial_state }

      it { subject.must_be_instance_of(NilClass) }
    end

    describe '#geometry' do
      let(:subject) { described_instance.geometry }

      it { subject.must_be_instance_of(Geometry) }
    end

    describe '#colour' do
      let(:subject) { described_instance.colour }

      it { subject.must_be_instance_of(Colour) }
    end
  end
end
