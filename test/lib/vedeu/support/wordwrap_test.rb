require_relative '../../../test_helper'
require_relative '../../../../lib/vedeu/support/wordwrap'

module Vedeu
  describe Wordwrap do
    let(:described_class) { Wordwrap }
    let(:value)           {
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. '    \
      "Curabitur aliquet turpis id dui condimentum elementum.\n"     \
      'Pellentesque blandit vulputate imperdiet. Quisque ut arcu '   \
      "dolor. Morbi nec vulputate purus.\n\nQuisque porta feugiat "  \
      'egestas. Aenean ac ipsum varius, lobortis lacus at, mattis '  \
      "est.\nQuisque viverra facilisis tortor, id convallis metus "  \
      'laoreet quis. Curabitur auctor nunc blandit enim volutpat '   \
      'hendrerit. Phasellus accumsan tempor iaculis. Ut in semper '  \
      "massa. Cras quis viverra elit.\n\nInteger vitae mattis est. " \
      'Cras id nisl porttitor lectus placerat gravida sit amet '     \
      "quis diam.\n\nDonec mollis, nisi sit amet congue sagittis, "  \
      'sapien magna rhoncus justo, vel molestie metus sapien eget '  \
      "libero.\n\n\n"
    }
    let(:options)         { {} }

    describe '#wordwrap' do
      let(:formatted_value) {
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. '  \
        "Curabitur\naliquet turpis id dui condimentum elementum.\n"  \
        'Pellentesque blandit vulputate imperdiet. Quisque ut arcu ' \
        "dolor.\nMorbi nec vulputate purus.\n\nQuisque porta "       \
        "feugiat egestas. Aenean ac ipsum varius, lobortis\nlacus "  \
        "at, mattis est.\nQuisque viverra facilisis tortor, id "     \
        "convallis metus laoreet quis.\nCurabitur auctor nunc "      \
        "blandit enim volutpat hendrerit. Phasellus\naccumsan "      \
        'tempor iaculis. Ut in semper massa. Cras quis viverra '     \
        "elit.\n\nInteger vitae mattis est. Cras id nisl porttitor " \
        "lectus placerat\ngravida sit amet quis diam.\n\nDonec "     \
        'mollis, nisi sit amet congue sagittis, sapien magna '       \
        "rhoncus\njusto, vel molestie metus sapien eget libero."
      }

      subject { described_class.this(value, options) }

      it 'returns a String' do
        subject.must_be_instance_of(String)
      end

      it 'returns formatted text' do
        subject.must_equal(formatted_value)
      end

      context 'when the content should be pruned' do
        let(:options)         { { width: 70, prune: true } }
        let(:formatted_value) {
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit.' \
          ' Curabitur a...'
        }

        it 'returns formatted text' do
          subject.must_equal(formatted_value)
        end
      end

      context 'when the content is less than the prune size' do
        let(:options) { { width: 70, prune: true } }
        let(:value)   { 'Some text...' }

        it 'returns formatted text' do
          subject.must_equal(value)
        end
      end
    end
  end
end
