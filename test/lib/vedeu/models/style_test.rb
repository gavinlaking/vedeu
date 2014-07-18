require_relative '../../../test_helper'
require_relative '../../../../lib/vedeu/models/presentation'
require_relative '../../../../lib/vedeu/models/style'

module Vedeu
  class TestStyle
    include Presentation
    include Style
  end

  describe Style do
    describe '#style' do
      it 'returns an escape sequence for a single style' do
        test_style = TestStyle.new(style: 'normal')
        test_style.style.must_equal("\e[24m\e[21m\e[27m")
      end

      it 'returns an escape sequence for multiple styles' do
        test_style = TestStyle.new(style: ['normal', 'underline'])
        test_style.style.must_equal("\e[24m\e[21m\e[27m\e[4m")
      end

      it 'returns an empty string for an unknown style' do
        test_style = TestStyle.new(style: 'unknown')
        test_style.style.must_equal('')
      end

      it 'has a style attribute' do
        test_style = TestStyle.new(style: ['normal'])
        test_style.style.must_equal("\e[24m\e[21m\e[27m")
      end

      it 'returns an empty string for empty or nil' do
        test_style = TestStyle.new(style: '')
        test_style.style.must_equal('')
      end

      it 'returns an empty string for empty or nil' do
        test_style = TestStyle.new(style: nil)
        test_style.style.must_equal('')
      end

      it 'returns an empty string for empty or nil' do
        test_style = TestStyle.new(style: [])
        test_style.style.must_equal('')
      end
    end

    describe '#style_original' do
      it 'returns an escape sequence for a single style' do
        test_style = TestStyle.new(style: 'normal')
        test_style.style_original.must_equal(['normal'])
      end

      it 'returns an escape sequence for multiple styles' do
        test_style = TestStyle.new(style: ['normal', 'underline'])
        test_style.style_original.must_equal(['normal', 'underline'])
      end

      it 'returns an empty string for an unknown style' do
        test_style = TestStyle.new(style: 'unknown')
        test_style.style_original.must_equal(['unknown'])
      end

      it 'has a style attribute' do
        test_style = TestStyle.new(style: ['normal'])
        test_style.style_original.must_equal(['normal'])
      end

      it 'returns an empty string for empty or nil' do
        test_style = TestStyle.new(style: '')
        test_style.style_original.must_equal([''])
      end

      it 'returns an empty string for empty or nil' do
        test_style = TestStyle.new(style: nil)
        test_style.style_original.must_equal('')
      end

      it 'returns an empty string for empty or nil' do
        test_style = TestStyle.new(style: [])
        test_style.style_original.must_equal('')
      end
    end
  end
end
