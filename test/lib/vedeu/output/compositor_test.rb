require 'test_helper'

module Vedeu

  describe Compositor do

    before do
      Buffers.reset
      Interfaces.reset
      Terminal.console.stubs(:print)
    end

    describe '.render' do
      before do
        Vedeu.interface('indium') do
          width  10
          height 1
        end
      end

      subject { Compositor.render('indium') }

      context 'when the buffer does not exist' do
        it 'raises an exception' do
          proc { Compositor.render('') }.must_raise(BufferNotFound)
        end
      end

      context 'when the buffer exists' do
        it 'returns a Array' do
          subject.must_be_instance_of(Array)
        end

        context 'when there is new content' do
          let(:back) {
            { name: 'indium', lines: [{ streams: [{ text: 'back' }] }] }
          }

          before { Buffers.add(back) }

          it 'returns the current/front content' do
            subject.must_equal([
              "\e[1;1H          \e[1;1H\e[1;1Hback",
              "\e[1;1H\e[?25l"
            ])
          end

          it 'swaps the new content with the current content' do
            Buffers.find('indium').back.must_equal(back)

            subject

            Buffers.find('indium').back.must_equal({})
            Buffers.find('indium').front.must_equal(back)
          end
        end

        context 'when there is no new content' do
          let(:front) {
            { name: 'indium', lines: [{ streams: [{ text: 'front' }] }] }
          }

          before do
            Buffers.add(front)
            Buffers.find('indium').swap
          end

          it 'returns the current/front content' do
            subject.must_equal([
              "\e[1;1H          \e[1;1H\e[1;1Hfront",
              "\e[1;1H\e[?25l"
            ])
          end
        end

        context 'when there is no new or current content' do
          let(:previous) {
            { name: 'indium', lines: [{ streams: [{ text: 'previous' }] }] }
          }

          before do
            Buffers.add(previous)       # puts 'previous' on to 'back'
            Buffers.find('indium').swap # puts 'back' ('previous') on to 'front'
            Buffers.find('indium').swap # puts 'front' ('previous') on to 'previous'
          end

          it 'returns the previous content' do
            subject.must_equal([
              "\e[1;1H          \e[1;1H\e[1;1Hprevious",
              "\e[1;1H\e[?25l"
            ])
          end
        end

        context 'when there is no new, current or previous content' do
          let(:clear) { { name: 'indium', lines: [] } }

          before { Buffers.add(clear) }

          it 'returns the escape sequences to clear the interface' do
            subject.must_equal(["\e[1;1H          \e[1;1H", "\e[1;1H\e[?25l"])
          end
        end
      end

      context 'when the interface cannot be found' do
        before do
          Interfaces.reset
          Buffers.add({ name: 'indium' })
        end

        it 'raises an exception' do
          proc { Compositor.render('indium') }.must_raise(InterfaceNotFound)
        end
      end
    end

    describe '#initialize' do
      it 'returns an instance of Compositor' do
        Compositor.new('indium').must_be_instance_of(Compositor)
      end
    end

  end # Compositor

end # Vedeu
