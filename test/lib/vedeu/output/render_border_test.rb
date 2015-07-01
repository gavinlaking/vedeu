require 'test_helper'

module Vedeu

  describe RenderBorder do

    let(:described) { Vedeu::RenderBorder }
    let(:instance)  { described.new(border) }
    let(:border)    {
      Vedeu.border 'Vedeu::RenderBorder' do
      end
    }

  end # RenderBorder

end # Vedeu
