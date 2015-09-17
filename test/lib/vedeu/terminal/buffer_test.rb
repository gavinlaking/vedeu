require 'test_helper'

module Vedeu

  module Terminal

    describe Buffer do

      let(:described) { Vedeu::Terminal::Buffer }
      let(:height)    { 2 }
      let(:width)     { 3 }

      before do
        Vedeu.stubs(:height).returns(height)
        Vedeu.stubs(:width).returns(width)
        Vedeu::Terminal::Buffer.reset
      end

      describe '#buffer' do
        let(:expected) {
          Array.new(height) do |y|
            Array.new(width) do |x|
              Vedeu::Models::Cell.new(position: [y + 1, x + 1])
            end
          end
        }

        subject { described.buffer }

        it { subject.must_be_instance_of(Array) }
        it { described.instance_variable_get('@output').must_equal(expected) }
        it { subject.must_equal(expected) }
      end

      describe '#empty_buffer' do
        let(:expected) {
          Array.new(height) do |y|
            Array.new(width) do |x|
              Vedeu::Models::Cell.new(position: [y + 1, x + 1])
            end
          end
        }

        subject { described.empty_buffer }

        it { subject.must_be_instance_of(Array) }
        it { subject.must_equal(expected) }
      end

      # describe '#output' do
      #   subject { described.output }

      #   context 'when nothing has been written to the buffer' do
      #     it {
      #       described.instance_variable_get('@output').must_equal(empty_buffer)
      #     }
      #   end

      #   context 'when something has been written to the buffer' do
      #     let(:expected) {
      #       exp = empty_buffer
      #       exp[1][2] = Vedeu::Views::Char.new(value: 'a', position: [1, 2])
      #       exp
      #     }

      #     before do
      #       described.write(Vedeu::Views::Char.new(value: 'a',
      #                                              position: [1, 2]))
      #     end

      #     it { described.instance_variable_get('@output').must_equal(expected) }
      #   end
      # end

      describe '#render' do
        let(:ready) { false }

        before { Vedeu.stubs(:ready?).returns(ready) }

        subject { described.render }

        context 'when Vedeu is not ready' do
          it { subject.must_equal(nil) }
        end

        context 'when Vedeu is ready' do
          let(:ready) { true }

          context 'when the buffer is empty' do
            # it {
            #   Vedeu.renderers.expects(:render).with(Vedeu::Models::Page)
            #   subject
            # }
          end

          context 'when the buffer is not empty' do
          end
        end
      end

      describe '#reset' do
        let(:output) {
          Array.new(height) do |y|
            Array.new(width) do |x|
              Vedeu::Models::Cell.new(position: [y + 1, x + 1])
            end
          end
        }

        subject { described.reset }

        it { described.instance_variable_get('@output').must_equal(output) }
        it { subject.must_be_instance_of(Array) }
        it { subject.must_equal(output) }

        it { described.must_respond_to(:clear) }
      end

      describe '#write' do
        let(:_value) {}

        subject { described.write(_value) }

        # context 'when the value is nil' do
        #   let(:expected) {
        #     [
        #       [
        #         Vedeu::Models::Cell.new(position: [1, 1]),
        #         Vedeu::Models::Cell.new(position: [1, 2]),
        #         Vedeu::Models::Cell.new(position: [1, 3])
        #       ], [
        #         Vedeu::Models::Cell.new(position: [2, 1]),
        #         Vedeu::Models::Cell.new(position: [2, 2]),
        #         Vedeu::Models::Cell.new(position: [2, 3])
        #       ]
        #     ]
        #   }

        #   it { subject.must_equal(described) }
        #   it { described.output.must_equal(expected) }
        # end

        # context 'when the value is not nil' do
        #   let(:_value)   { Vedeu::Views::Char.new(y: 2, x: 1, value: 'a') }
        #   let(:expected) {

        #   }

        #   it { subject.must_equal(described) }
        #   it { described.output.must_equal(expected) }
        # end
      end

    end # Buffer

  end # Terminal

end # Vedeu

# require 'test_helper'

# module Vedeu

#   module Buffers

#     describe VirtualBuffer do

#       let(:described) { Vedeu::Buffers::VirtualBuffer }
#       let(:instance)  { described.new(height, width, renderer) }
#       let(:height)    { 3 }
#       let(:width)     { 3 }
#       let(:renderer)  { Vedeu::Renderers::HTML.new }

#       describe '#initialize' do
#         it { instance.must_be_instance_of(described) }
#         it { instance.instance_variable_get('@height').must_equal(3) }
#         it { instance.instance_variable_get('@width').must_equal(3) }
#         it { instance.instance_variable_get('@renderer').must_equal(renderer) }
#       end

#       describe 'accessors' do
#         it { instance.must_respond_to(:renderer) }
#         it { instance.must_respond_to(:renderer=) }
#         it { instance.must_respond_to(:height) }
#         it { instance.must_respond_to(:width) }
#       end

#       describe '.output' do
#         let(:data) {}

#         before do
#           Vedeu.stubs(:width).returns(3)
#           Vedeu.stubs(:height).returns(3)
#         end

#         subject { described.output(data) }

#         it { subject.must_be_instance_of(Array) }
#       end

#       describe '#cells' do
#         before do
#           Vedeu.stubs(:width).returns(3)
#           Vedeu.stubs(:height).returns(3)
#         end

#         subject { instance.cells }

#         it { subject.must_be_instance_of(Array) }
#         it { subject.size.must_equal(3) }
#         it { subject.flatten.size.must_equal(9) }
#       end

#       describe '#read' do
#         subject { instance.read(y, x) }

#         context 'when x is out of bounds' do
#           let(:y) { 1 }
#           let(:x) { 5 }

#           it { subject.must_equal([]) }
#         end

#         context 'when y is out of bounds' do
#           let(:y) { 5 }
#           let(:x) { 1 }

#           it { subject.must_equal([]) }
#         end

#         context 'when both x and y are out of bounds' do
#           let(:y) { 5 }
#           let(:x) { 5 }

#           it { subject.must_equal([]) }
#         end

#         context 'when x and y are in bounds' do
#           let(:y) { 0 }
#           let(:x) { 2 }

#           it { subject.must_be_instance_of(Vedeu::Models::Cell) }
#         end
#       end

#       describe '#output' do
#         it { instance.must_respond_to(:output) }
#       end

#       describe '#render' do
#         before do
#           Vedeu.stubs(:width).returns(3)
#           Vedeu.stubs(:height).returns(3)
#         end

#         subject { instance.render }

#         it { subject.must_be_instance_of(String) }
#       end

#       describe '#reset' do
#         subject { instance.reset }

#         it { subject.must_be_instance_of(Array) }

#         it { instance.must_respond_to(:clear) }
#       end

#       describe '#write' do
#         let(:data) { Vedeu::Views::Char.new(value: 'a') }

#         subject { instance.write(y, x, data) }

#         context 'when x is out of bounds' do
#           let(:y) { 1 }
#           let(:x) { 5 }

#           it { subject.must_equal(false) }
#         end

#         context 'when y is out of bounds' do
#           let(:y) { 5 }
#           let(:x) { 1 }

#           it { subject.must_equal(false) }
#         end

#         context 'when both x and y are out of bounds' do
#           let(:y) { 5 }
#           let(:x) { 5 }

#           it { subject.must_equal(false) }
#         end

#         context 'when x and y are in bounds' do
#           let(:y) { 0 }
#           let(:x) { 2 }

#           it { subject.must_equal(true) }
#         end
#       end

#     end # VirtualBuffer

#   end # Buffers

# end # Vedeu
