require_relative '../../../test_helper'

module Vedeu
  module Colour
    describe Translator do
      let(:klass) { Translator }

      describe '#translate' do
        {
          '#ff0000' => 196, # red
          '#00ff00' => 46,  # green
          '#0000ff' => 21,  # blue
          '#ffffff' => 231, # white
          '#aadd00' => 148, # lime green
          '#b94f1c' => 130, # sunset orange
        }.map do |html_colour, terminal_colour|
          context 'when a colour is provided' do
            it 'translation is performed' do
              klass.translate(html_colour)
                .must_equal terminal_colour
            end
          end
        end

        context 'when a colour is not provided' do
          it 'no translation is performed' do
            klass.translate(nil).must_equal nil
          end
        end
      end
    end
  end
end
