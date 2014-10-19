require 'test_helper'

module Vedeu

  describe Compositor do

    before do
      Interfaces.reset
      Terminal.console.stubs(:print)
    end

    describe '.render' do
      it 'raises an exception if the buffer/interface cannot be found' do
        proc { Compositor.render('') }.must_raise(BufferNotFound)
      end

      context 'when the buffer is nil' do
        it 'clears the defined area for the interface' do
          Vedeu.interface('xenon') do
            x      1
            y      1
            width  5
            height 3
          end

          Vedeu.focus('xenon')

          Compositor.render('xenon').must_equal([
            "\e[1;1H     \e[1;1H" \
            "\e[2;1H     \e[2;1H" \
            "\e[3;1H     \e[3;1H" \
            "\e[1;1H\e[?25h"
          ])
        end
      end

      context 'when the buffer is not nil' do
        it 'renders the content in the defined area for the interface' do
          Vedeu.interface('neon') do
            x      1
            y      1
            width  5
            height 3
          end

          Vedeu.focus('neon')

          class MyCompositorView < Vedeu::View
            def render
              view 'neon' do
                line 'argon'
                line 'boron'
                line 'radon'
              end
            end
          end

          MyCompositorView.render

          Compositor.render('neon').must_equal([
            "\e[1;1H     \e[1;1H" \
            "\e[2;1H     \e[2;1H" \
            "\e[3;1H     \e[3;1H" \
            "\e[1;1Hargon" \
            "\e[2;1Hboron" \
            "\e[3;1Hradon" \
            "\e[1;1H\e[?25h"
          ])
        end
      end
    end

  end # Compositor

end # Vedeu
