require 'test_helper'

module Vedeu

	describe Plugins do

    let(:described) { Vedeu::Plugins }
    let(:instance)  { described.new }

    describe '#initialize' do
      it { instance.must_be_instance_of(described) }
    end

    describe '#load' do
      subject { instance.load }

      it { subject.must_be_instance_of(Array) }
    end

    describe '#register' do
      let(:_name) {}
      let(:plugin) { false }

      subject { instance.register(_name, plugin) }

      # @todo Add more tests.
      # it { skip }
    end

    describe '#find' do
      subject { instance.find }

      it { subject.must_be_instance_of(Array) }
    end

    describe '#names' do
      subject { instance.names }

      it { subject.must_be_instance_of(Hash) }

      context 'when no plugins are registered' do
        it { subject.must_equal({}) }
      end

      context 'when plugins are registered' do
        # @todo Add more tests.
        # it { skip }
      end
    end

	end # Plugins

end # Vedeu
