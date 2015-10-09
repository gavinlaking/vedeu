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

      describe '.render_output' do
        subject { described.render_output(output) }

        context 'when the output is empty' do
          it { subject.must_be_instance_of(NilClass) }
        end

        context 'when the output is not empty' do
          context 'and the output is an escape sequence' do
            let(:output) {
              Vedeu::Models::Escape.new(value: "\e[?25h", position: [1, 1])
            }

            it {
              Vedeu::Terminal.expects(:output)
              subject
            }
          end

          context 'and the output is not an escape sequence' do
            let(:output) { Vedeu::Models::Page.new }

            it {
              Vedeu::Terminal::Buffer.expects(:write).with(output)
              subject
            }
          end
        end
      end

      describe '#render_output' do
        it { instance.must_respond_to(:render_output) }
      end

    end # Output

  end # Output

end # Vedeu
