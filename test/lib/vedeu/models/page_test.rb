# frozen_string_literal: true

require 'test_helper'

module Vedeu

  module Models

    describe Page do

      let(:described) { Vedeu::Models::Page }
      let(:instance)  { described.new(rows) }
      let(:rows)      {
        [
          [:hydrogen, :helium, :lithium],
          [:beryllium, :boron, :carbon],
          [:nitrogen, :oxygen, :fluorine],
        ]
      }

      describe '#initialize' do
        it { instance.must_be_instance_of(described) }

        context 'when there are no rows' do
          let(:rows) {}

          it { instance.instance_variable_get('@rows').must_equal([]) }
        end

        context 'when there are rows' do
          it { instance.instance_variable_get('@rows').must_equal(rows) }
        end
      end

      describe '.coerce' do
        it { described.must_respond_to(:coerce) }
      end

      describe '#rows' do
        it { instance.must_respond_to(:rows) }
      end

      describe '#cell' do
        let(:row_index)  {}
        let(:cell_index) {}

        subject { instance.cell(row_index, cell_index) }

        context 'when the row_index is nil' do
          it { subject.must_equal(nil) }
        end

        context 'when the row_index is not nil' do
          let(:row_index) { 1 }

          context 'and the row_index is in range' do
            let(:row_index) { 1 }

            context 'when the cell_index is nil' do
              it { subject.must_equal(nil) }
            end

            context 'when the cell_index is not nil' do
              context 'and the cell_index is in range' do
                let(:cell_index) { 2 }

                it { subject.must_equal(:carbon) }
              end

              context 'and the cell_index is out of range' do
                let(:cell_index) { 4 }

                it { subject.must_equal(nil) }
              end

              context 'and the cell_index is out of range' do
                let(:cell_index) { -4 }

                it { subject.must_equal(nil) }
              end
            end
          end

          context 'and the row_index is out of range' do
            let(:row_index) { 4 }

            it { subject.must_equal(nil) }
          end

          context 'and the row_index is out of range' do
            let(:row_index) { -4 }

            it { subject.must_equal(nil) }
          end
        end
      end

      # describe '#content' do
      #   subject { instance.content }

      #   it { subject.must_equal() }
      # end

      describe '#each' do
        subject { instance.each }

        it { subject.must_be_instance_of(Enumerator) }
      end

      describe '#empty?' do
        subject { instance.empty? }

        context 'when the page is empty' do
          let(:rows) { [] }

          it { subject.must_equal(true) }
        end

        context 'when the pages is not empty' do
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

      describe '#row' do
        let(:index) {}

        subject { instance.row(index) }

        context 'when the index is nil' do
          it { subject.must_equal(nil) }
        end

        context 'when the index is not nil' do
          context 'and the index is in range' do
            let(:index) { 1 }

            it { subject.must_equal([:beryllium, :boron, :carbon]) }
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

      describe '#size' do
        subject { instance.size }

        it { subject.must_be_instance_of(Integer) }
      end

    end # Page

  end # Models

end # Vedeu
