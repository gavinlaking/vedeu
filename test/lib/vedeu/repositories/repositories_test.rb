# frozen_string_literal: true

require 'test_helper'

module Vedeu

  describe Repositories do

    let(:described) { Vedeu::Repositories }

    describe '.all' do
      # let(:expected) {
      #   [
      #     Vedeu::Cursors::Repository.new,
      #     Vedeu::Buffers::Repository.new,
      #     Vedeu::Groups::Repository.new,
      #     Vedeu::Interfaces::Repository.new,
      #   ]
      # }

      subject { described.all }

      # it { subject.must_equal(expected) }
    end

    describe '.register' do
      subject { described.register(klass) }

      context 'when the klass is nil' do
        let(:klass) {}

        it { assert_nil(subject) }
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

      # context 'when there is nothing registered' do
      #   let(:expected) { [[], [], [], []] }

      #   it { subject.must_equal(expected) }
      # end
    end

    describe '.repositories' do
      subject { described.repositories }

      it { Vedeu.must_respond_to(:repositories) }

      it { subject.must_equal(described) }
    end

    describe '.reset!' do
      subject { described.reset! }

      it { described.must_respond_to(:reset) }
      it { subject.must_equal(true) }
    end

  end # Repositories

end # Vedeu
