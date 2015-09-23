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

      describe '.render' do
        subject { described.render(output) }

        context 'when the output is empty' do
          it { subject.must_be_instance_of(NilClass) }
        end

        context 'when the output is not empty' do
          context 'and the output is an escape sequence' do
            let(:output) {
              Vedeu::Models::Escape.new(value: "\e[?25h", position: [1, 1])
            }

            before { Vedeu::Output::Direct.stubs(:write).returns(output.to_s) }

            it { subject.must_equal("\e[1;1H\e[?25h") }
          end

          context 'and the output is not an escape sequence' do
            let(:output) { Vedeu::Models::Page.new }
            let(:buffer) { mock('Vedeu::Terminal::Buffer') }

            before do
              Vedeu::Terminal::Buffer.stubs(:write)
              buffer.expects(:render).returns(output)
            end

            it {
              Vedeu::Terminal::Buffer.expects(:write).with(output).returns(buffer)
              subject
            }
          end
        end
      end

      describe '#render' do
        it { instance.must_respond_to(:render) }
      end

    end # Output

  end # Output

end # Vedeu
