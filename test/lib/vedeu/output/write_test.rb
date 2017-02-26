# frozen_string_literal: true

require 'test_helper'

module Vedeu

  module Output

    describe Write do

      let(:described) { Vedeu::Output::Write }
      let(:instance)  { described.new(output, options) }
      let(:output)    {}
      let(:options)   { {} }

      describe '#initialize' do
        it { instance.must_be_instance_of(described) }
        it { instance.instance_variable_get('@output').must_equal(output) }
        it { instance.instance_variable_get('@options').must_equal(options) }
      end

      describe '.write' do
        before do
          Vedeu::Terminal.stubs(:output)
        end

        subject { described.write(output, options) }

        context 'when the output is empty' do
          let(:expected) { "\e[1;1H\e[0m\e[1;1H" }

          it { subject.must_equal(expected) }
        end

        context 'when the output is not empty' do
          let(:output)   { 'Some text...' }
          let(:expected) { "\e[1;1HSome text...\e[0m\e[1;13H" }

          it { subject.must_equal(expected) }
        end

        context 'when a colour is provided' do
          let(:output) { 'Some text...' }
          let(:options) {
            {
              colour: { background: '#ff0000', foreground: '#ffff00' }
            }
          }
          let(:expected) {
            "\e[1;1H"            \
            "\e[38;2;255;255;0m" \
            "\e[48;2;255;0;0m"   \
            "Some text..."       \
            "\e[0m"              \
            "\e[1;13H"           \
          }

          it { subject.must_equal(expected) }
        end

        context 'when a style is provided' do
          let(:output) { 'Some text...' }
          let(:options) {
            {
              style: :underline,
            }
          }
          let(:expected) { "\e[1;1H\e[4mSome text...\e[0m\e[1;13H" }

          it { subject.must_equal(expected) }
        end
      end

      describe '#parent' do
        subject { instance.parent }

        it { assert_nil(subject) }
      end

      describe '#position' do
        subject { instance.position }

        it { subject.must_be_instance_of(Vedeu::Geometries::Position) }
      end

      describe '#write' do
        it { instance.must_respond_to(:write) }
      end

    end # Write

  end # Output

end # Vedeu
