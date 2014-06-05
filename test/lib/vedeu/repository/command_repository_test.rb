require_relative '../../../test_helper'

module Vedeu
  describe CommandRepository do
    let(:described_class) { CommandRepository }

    describe '.define' do
      it { skip }
    end

    describe '.add' do
      it { skip }
    end

    describe '.execute' do
      it { skip }
    end

    describe '.klass' do
      let(:subject) { described_class.klass }

      it { subject.must_equal(Command) }
    end
  end
end
