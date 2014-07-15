require_relative '../../../test_helper'
require_relative '../../../../lib/vedeu/support/translator'

module Vedeu
  describe Translator do
    let(:html_colour) {}

    describe '#initialize' do
      def subject
        Translator.new(html_colour)
      end

      it 'returns a Translator instance' do
        subject.must_be_instance_of(Translator)
      end
    end

    describe '#translate' do
      {
        '#ff0000' => 196, # red
        '#00ff00' => 46,  # green
        '#0000ff' => 21,  # blue
        '#ffffff' => 231, # white
        '#aadd00' => 148, # lime green
        '#b94f1c' => 130, # sunset orange
      }.map do |html_colour, terminal_colour|
        context 'valid' do
          it 'translation is performed' do
            Translator.translate(html_colour).must_be_instance_of(Fixnum)

            Translator.translate(html_colour).must_equal(terminal_colour)
          end
        end
      end

      context 'invalid' do
        it 'returns empty string when not present' do
          Translator.translate.must_equal('')
        end

        it 'returns empty string when the wrong type!' do
          Translator.translate(:wrong_type).must_equal('')
        end

        it 'returns empty string when invalid format' do
          Translator.translate('345678').must_equal('')
        end

        it 'returns empty string when invalid format' do
          Translator.translate('#h11111').must_equal('')
        end

        it 'returns empty string when invalid format' do
          Translator.translate('#1111').must_equal('')
        end
      end
    end
  end
end
