# frozen_string_literal: true

require 'test_helper'

module Vedeu

  module Output

    describe Output do

      let(:described) { Vedeu::Output::Output }
      let(:instance)  { described.new(output) }
      let(:output)    {}
      let(:drb)       { false }

      describe '#initialize' do
        it { instance.must_be_instance_of(described) }
        it { instance.instance_variable_get('@output').must_equal(output) }
      end

      describe '.buffer_update' do
        it { described.must_respond_to(:buffer_update) }
      end

      describe '.buffer_write' do
        subject { described.buffer_write(output) }

        context 'when the output is empty' do
          it { subject.must_be_instance_of(NilClass) }
        end

        context 'when the output is not empty' do
          let(:output) { Vedeu::Cells::Char.new(value: 'a') }

          it do
            Vedeu::Buffers::Terminal.expects(:write).with(output)
            subject
          end
        end
      end

      describe '.direct_write' do
        subject { described.direct_write(output) }

        context 'when the output is empty' do
          it { subject.must_be_instance_of(NilClass) }
        end

        context 'when the output is not empty' do
          let(:output) {
            Vedeu::Cells::Escape.new(value: "\e[?25h", position: [1, 1])
          }

          it do
            Vedeu::Terminal.expects(:output).with(output.to_s)
            subject
          end
        end
      end

      describe '.render_output' do
        subject { described.render_output(output) }

        context 'when the output is empty' do
          it { subject.must_be_instance_of(NilClass) }
        end

        context 'when the output is not empty' do
          context 'and the output is an escape sequence' do
            let(:output) {
              Vedeu::Cells::Escape.new(value: "\e[?25h", position: [1, 1])
            }

            it do
              Vedeu::Terminal.expects(:output).with(output.to_s)
              subject
            end
          end

          context 'and the output is not an escape sequence' do
            let(:output) { Vedeu::Cells::Char.new(value: 'a') }

            it do
              Vedeu::Buffers::Terminal.expects(:write).with(output)
              subject
            end
          end
        end
      end

      describe '#buffer_update' do
        it { instance.must_respond_to(:buffer_update) }
      end

      describe '#buffer_write' do
        it { instance.must_respond_to(:buffer_write) }
      end

      describe '#direct_write' do
        it { instance.must_respond_to(:direct_write) }
      end

      describe '#render_output' do
        it { instance.must_respond_to(:render_output) }
      end

    end # Output

  end # Output

end # Vedeu
