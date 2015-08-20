require 'test_helper'

module Vedeu

  module Editor

    describe Line do

      let(:described) { Vedeu::Editor::Line }
      let(:instance)  { described.new }
      let(:console)   { mock }

      describe '#initialize' do
        it { instance.must_be_instance_of(described) }
      end

      describe '.read' do
        subject { described.read }

        before do
          Vedeu::Terminal.stubs(:console).returns(console)
          console.stubs(:getch).returns(keys)
        end

        context 'when nothing is given' do
          let(:keys) { nil }
        end

        context 'when a single keypress is given' do
          let(:keys) { 'a' }

          it { subject.must_equal('a') }
        end

        context 'when a ctrl+keypress is given' do
          let(:keys) { "\u0001" }

          it { subject.must_equal(:ctrl_a) }
        end

        context 'when a shift+keypress is given' do
          let(:keys) { 'A' }

          it { subject.must_equal('A') }
        end

        context 'when a alt+keypress is given' do
        end

        context 'when a super+keypress is given' do
        end
      end

      describe '#read' do
        it { instance.must_respond_to(:read) }
      end

    end # Line

  end # Editor

end # Vedeu
