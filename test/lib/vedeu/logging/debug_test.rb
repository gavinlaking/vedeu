# frozen_string_literal: true

require 'test_helper'

module Vedeu

  module Logging

    describe Debug do

      let(:described) { Vedeu::Logging::Debug }

      before do
        File.stubs(:open).with(Dir.tmpdir + '/vedeu_profile', 'w').returns(:some_code)
      end

      describe '.debug' do
        let(:_binding) {}
        let(:_obj)     {}

        subject { described.debug(_binding, _obj) }

        context 'when pry is available' do
          # @todo Add more tests.
        end

        context 'when pry is not available' do
          before { Vedeu.stubs(:requires_gem!).raises(Vedeu::Error::Fatal) }

          it { proc { subject }.must_raise(Vedeu::Error::Fatal) }
        end
      end

      describe '.profile' do
        let(:filename)  { 'vedeu_profile' }
        let(:some_code) { :some_code }

        subject { described.profile(filename) { some_code } }

        context 'when ruby-prof is available' do
          before { Vedeu.stubs(:requires_gem!).returns(true) }

          context 'when the block is not given' do
            subject { described.profile(filename) }

            it { proc { subject }.must_raise(Vedeu::Error::RequiresBlock) }
          end

          context 'when the block is given' do
            subject { described.profile(filename) { some_code } }

            it { subject.must_equal(some_code) }
          end
        end

        context 'when ruby-prof is not available' do
          before { Vedeu.stubs(:requires_gem!).raises(Vedeu::Error::Fatal) }

          it { proc { subject }.must_raise(Vedeu::Error::Fatal) }
        end
      end

    end # Debug

  end # Logging

end # Vedeu
