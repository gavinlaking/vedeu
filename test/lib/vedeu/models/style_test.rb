require 'test_helper'
require 'vedeu/models/style'

module Vedeu
  class TestStyle
    include Virtus.model

    attribute :style, Style
  end

  describe Style do
    describe '#style' do
      it 'returns an escape sequence for a single style' do
        model = TestStyle.new(style: 'normal')
        model.style.must_equal("\e[24m\e[21m\e[27m")
      end

      it 'returns an escape sequence for multiple styles' do
        model = TestStyle.new(style: ['normal', 'underline'])
        model.style.must_equal("\e[24m\e[21m\e[27m\e[4m")
      end

      it 'returns an empty string for an unknown style' do
        model = TestStyle.new(style: 'unknown')
        model.style.must_equal('')
      end

      it 'has a style attribute' do
        model = TestStyle.new(style: ['normal'])
        model.style.must_equal("\e[24m\e[21m\e[27m")
      end

      it 'returns an empty string for empty or nil' do
        model = TestStyle.new(style: '')
        model.style.must_equal('')
      end

      it 'returns an empty string for empty or nil' do
        model = TestStyle.new(style: nil)
        model.style.must_equal('')
      end

      it 'returns an empty string for empty or nil' do
        model = TestStyle.new(style: [])
        model.style.must_equal('')
      end
    end
  end
end
