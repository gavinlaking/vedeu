require_relative '../../../test_helper'

module Vedeu
  module Input
    describe Keyboard do
      let(:klass)   { Keyboard }
      let(:options) { {} }

      before { Terminal.stubs(:input).returns(*input) }

      subject { Keyboard.capture(options) }

      context 'handles a sequence' do
        let(:input) { [66, 67, 68, nil] }

        it { subject.must_equal(['B', 'C', 'D']) }
      end

      context 'handles a space' do
        let(:input) { [32, nil] }

        it { subject.must_equal([' ']) }
      end

      context 'handles ctrl+x' do
        let(:input) { [26, nil] }

        it { subject.must_equal([:'Ctrl+z']) }
      end

      context 'handles return/enter' do
        let(:input) { [13, nil] }

        it { subject.must_equal([:enter]) }
      end

      context 'handles utf-8 characters' do
        let(:input) { [195, 164, nil] }

        it { subject.must_equal(['ä']) }
      end

      context 'handles control characters' do
        let(:input) { [260, 127, 127, 261, 260, 195, 164, 261, 260, 195, 164, nil] }

        it { subject.must_equal([:left, :backspace, :backspace, :right, :left, "ä", :right, :left, "ä"]) }
      end

      context 'handles unprintable keys' do
        let(:input) { [11121, 324234, nil] }

        it { subject.must_equal([11121, 324234]) }
      end

      context 'handles escape sequence for Shift+down' do
        let(:input) { [27, 91, 49, 59, 50, 66, nil] }

        it { subject.must_equal([:"Shift+down"]) }
      end

      context 'handles long escape sequences' do
        let(:input) { [27, 91, 49, 59, 50, 66, 59, 50, 66, 59, 50, 66, nil] }

        it { subject.must_equal([:escape, "[", "1", ";", "2", "B", ";", "2", "B", ";", "2", "B"]) }
      end

      context 'handles escape sequence for Shift+up' do
        let(:input) { [27, 91, 49, 59, 50, 65, nil] }

        it { subject.must_equal([:"Shift+up"]) }
      end

      context 'handles escape sequence for Mac OSX iTerm Ctrl+Shift+right' do
        let(:input) { [27, 91, 67, nil] }

        it { subject.must_equal([:"Ctrl+Shift+right"]) }
      end

      context 'handles escape sequence for Mac OSX iTerm Ctrl+Shift+left' do
        let(:input) { [27, 27, 91, 68, nil] }

        it { subject.must_equal([:"Ctrl+Shift+left"]) }
      end

      context 'handles Alt+x codes' do
        let(:input) { [27, 103, nil] }

        it { subject.must_equal([:"Alt+g"]) }
      end

      context 'handles the escape key press' do
        let(:input) { [27, nil] }

        it { subject.must_equal([:escape]) }
      end
    end
  end
end
