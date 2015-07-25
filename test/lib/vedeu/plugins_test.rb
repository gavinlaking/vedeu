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

      # @todo
      # it { skip }
    end

    describe '#register' do
      let(:_name) {}
      let(:plugin) { false }

      subject { instance.register(_name, plugin) }

      # @todo
      # it { skip }
    end

    describe '#find' do
      subject { instance.find }

      # @todo
      # it { skip }
    end

    describe '#names' do
      subject { instance.names }

      # @todo
      # it { skip }
    end

	end # Plugins

end # Vedeu
