require 'test_helper'

module Vedeu

  describe Cursors do

    before do
      Cursors.reset
      Registrar.record({ name: 'chromium' })
    end

    describe '#hide' do
      it 'sets the state attribute of the Cursor to :hide' do
        cursor = Cursors.hide
        cursor.state.must_equal(:hide)
      end
    end

    describe '#show' do
      it 'sets the state attribute of the Cursor to :show' do
        cursor = Cursors.show
        cursor.state.must_equal(:show)
      end
    end

  end # Cursors

end # Vedeu
