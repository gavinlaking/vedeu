require 'test_helper'

module Vedeu

  describe Repositories do

    let(:described) { Vedeu::Repositories }

    describe '.register' do
      subject { described.register(klass) }

      context 'when the klass is nil' do
        let(:klass) {}

        it { subject.must_equal(nil) }
      end

      context 'when the klass is a repository class' do
        let(:klass) { Vedeu::Buffers }

        it { subject.wont_be_empty }
      end
    end

    describe '.registered' do
      before { described.reset! }

      subject { described.registered }

      # @todo
      # it { skip }
    end

    describe '.reset!' do
      subject { described.reset! }

      it { subject.must_equal(true) }
    end

  end # Repositories

end # Vedeu
