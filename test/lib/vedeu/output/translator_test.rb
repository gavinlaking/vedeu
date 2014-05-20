require_relative '../../../test_helper'

module Vedeu
  describe Translator do
    let(:described_class)       { Translator }
    let(:instance)    { described_class.new(html_colour) }
    let(:html_colour) {}

    it { instance.must_be_instance_of(Translator) }

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
            described_class.translate(html_colour).must_be_instance_of(Fixnum)

            described_class.translate(html_colour).must_equal(terminal_colour)
          end
        end
      end

      context 'invalid' do
        it 'returns nil when not present' do
          described_class.translate.must_equal(nil)
        end

        it 'returns nil when the wrong type' do
          described_class.translate(:wrong_type).must_equal(nil)
        end

        it 'returns nil when invalid format' do
          described_class.translate('345678').must_equal(nil)
        end

        it 'returns nil when invalid format' do
          described_class.translate('#h11111').must_equal(nil)
        end

        it 'returns nil when invalid format' do
          described_class.translate('#1111').must_equal(nil)
        end
      end
    end
  end
end
