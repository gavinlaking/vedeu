require_relative '../../../test_helper'

module Vedeu
  describe Command do
    let(:described_class)    { Command }
    let(:described_instance) { described_class.new(attributes) }
    let(:attributes)         { { name: :test_command } }

    it { described_instance.must_be_instance_of(Command) }

    describe '#create' do
      let(:subject) { described_class.create(attributes) }

      it { subject.must_be_instance_of(Command) }
    end

    describe '#execute' do
      let(:subject) { described_instance.execute(args) }
    end

    describe '#executable' do
      let(:subject) { described_instance.executable }
    end

    describe '#execute' do
      let(:subject) { described_instance.execute }
    end
  end
end
