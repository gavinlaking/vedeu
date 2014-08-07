require 'test_helper'
require 'vedeu/output/view'

module Vedeu
  describe View do
    describe '.render' do
      it 'returns when the type is :json' do
        skip
        View.render(:json, '').must_equal('')
      end

      it 'returns when the type is :raw' do
        skip
        View.render(:raw, '').must_equal('')
      end

      it 'returns when the type is :menu' do
        skip
        View.render(:menu, '').must_equal('')
      end

      it 'returns when the type is not set' do
        proc { View.render(nil, '') }.must_raise(KeyError)
      end

      it 'returns when the type is not recognised' do
        proc { View.render(:unknown, '') }.must_raise(KeyError)
      end
    end
  end
end
