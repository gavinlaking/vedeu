# frozen_string_literal: true

require 'test_helper'

module Vedeu

  module Runtime

    describe Traps do

      let(:described) { Vedeu::Runtime::Traps }
      let(:keys) { :SIGWINCH }

      describe '.add_signal_trap' do
        subject { described.add_signal_trap(keys) { } }

        context 'when the required block was given' do
          context 'when signals were given' do
            it { subject.must_equal([:SIGWINCH]) }
          end

          context 'when no signals were given' do
            let(:keys) {}

            it { subject.must_equal([nil]) }
          end
        end

        context 'when the required block was not given' do
          subject { described.add_signal_trap(keys) }

          it { proc { subject }.must_raise(Vedeu::Error::RequiresBlock) }
        end
      end

    end # Traps

  end # Runtime

end # Vedeu
