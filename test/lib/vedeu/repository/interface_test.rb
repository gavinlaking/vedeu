require_relative '../../../test_helper'

module Vedeu
  describe Interface do
    let(:described_class)    { Interface }
    let(:described_instance) { described_class.new(attributes) }
    let(:subject)            { described_instance }
    let(:attributes)         {
      {
        name:   'dummy',
        width:  40,
        height: 5,
        x:      1,
        y:      1,
        fg:     :red,
        bg:     :blue
      }
    }
    let(:result)             {}

    it 'returns an Interface instance' do
      subject.must_be_instance_of(Interface)
    end

    it 'sets an instance variable' do
      subject.instance_variable_get("@attributes").must_equal(attributes)
    end

    it 'sets an instance variable' do
      subject.instance_variable_get("@active").must_equal(false)
    end

    it 'sets an instance variable' do
      subject.instance_variable_get("@name").must_equal('dummy')
    end

    describe '#create' do
      let(:subject) { described_class.create(attributes) }

      it 'returns an Interface' do
        subject.must_be_instance_of(Interface)
      end
    end

    describe '#initial_state' do
      let(:subject) { described_instance.initial_state }

      before { Compositor.stubs(:arrange) }

      it 'returns a NilClass' do
        subject.must_be_instance_of(NilClass)
      end
    end

    describe '#geometry' do
      let(:subject) { described_instance.geometry }

      it 'returns a Geometry' do
        subject.must_be_instance_of(Geometry)
      end
    end

    describe '#colour' do
      let(:subject) { described_instance.colour }

      it 'returns a Colour' do
        subject.must_be_instance_of(Colour)
      end
    end
  end
end
