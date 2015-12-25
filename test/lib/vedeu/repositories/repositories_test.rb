# frozen_string_literal: true

require 'test_helper'

module Vedeu

  describe Repositories do

    let(:described) { Vedeu::Repositories }

    describe '.all' do
      subject { described.all }

      # @todo Add more tests.
    end

    describe '.register' do
      subject { described.register(klass) }

      context 'when the klass is nil' do
        let(:klass) {}

        it { subject.must_equal(nil) }
      end

      context 'when the klass is a repository class' do
        let(:klass) { Vedeu::Buffers::Repository }

        it { subject.wont_be_empty }
      end
    end

    describe '.registered' do
      before {
        Vedeu.stubs(:log)
        described.reset!
      }

      subject { described.registered }

      # @todo Add more tests.
      # it { skip }
    end

    describe '.reset!' do
      subject { described.reset! }

      it { described.must_respond_to(:reset) }
      it { subject.must_equal(true) }
    end

  end # Repositories

end # Vedeu
