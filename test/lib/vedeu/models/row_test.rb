# frozen_string_literal: true

require 'test_helper'

module Vedeu

  module Models

    describe Row do

      let(:described) { Vedeu::Models::Row }
      let(:instance)  { described.new(cells) }
      let(:cells)     {
        [
          Vedeu::Cells::Char.new(value: 'A'),
          Vedeu::Cells::Empty.new(value: 'B'),
          Vedeu::Cells::Char.new(value: 'C'),
        ]
      }

      describe '#initialize' do
        it { instance.must_be_instance_of(described) }

        context 'when there are no cells' do
          let(:cells) {}

          it { instance.instance_variable_get('@cells').must_equal([]) }
        end

        context 'when there are cells' do
          it { instance.instance_variable_get('@cells').must_equal(cells) }
        end
      end

      describe '.coerce' do
        it { described.must_respond_to(:coerce) }
      end

      describe '#cell' do
        let(:index) {}

        subject { instance.cell(index) }

        context 'when the index is nil' do
          it { subject.must_equal(nil) }
        end

        context 'when the index is not nil' do
          context 'and the index is in range' do
            let(:expected) { Vedeu::Cells::Char.new(value: 'C') }

            let(:index) { 2 }

            it { subject.must_equal(expected) }
          end

          context 'and the index is out of range' do
            let(:index) { 4 }

            it { subject.must_equal(nil) }
          end

          context 'and the index is out of range' do
            let(:index) { -4 }

            it { subject.must_equal(nil) }
          end
        end
      end

      describe '#content' do
        let(:expected) {
          [
            Vedeu::Cells::Char.new(value: 'A'),
            Vedeu::Cells::Empty.new(value: 'B'),
            Vedeu::Cells::Char.new(value: 'C'),
            Vedeu::Cells::Escape.new(value: "\e[0m"),
          ]
        }

        subject { instance.content }

        it { subject.must_equal(expected) }
      end

      describe '#each' do
        subject { instance.each }

        it { subject.must_be_instance_of(Enumerator) }
      end

      describe '#empty?' do
        subject { instance.empty? }

        context 'when the row is empty' do
          let(:cells) { [] }

          it { subject.must_equal(true) }
        end

        context 'when the row is not empty' do
          it { subject.must_equal(false) }
        end
      end

      describe '#eql?' do
        let(:other) { instance }

        subject { instance.eql?(other) }

        it { subject.must_equal(true) }

        context 'when different to other' do
          let(:other) { described.new([:hydrogen]) }

          it { subject.must_equal(false) }
        end
      end

      describe '#==' do
        it { instance.must_respond_to(:==) }
      end

      describe '#reset_character' do
        subject { instance.reset_character }

        it { subject.must_be_instance_of(Vedeu::Cells::Escape) }
      end

      describe '#size' do
        subject { instance.size }

        it { subject.class < Integer }
      end

    end # Row

  end # Models

end # Vedeu
