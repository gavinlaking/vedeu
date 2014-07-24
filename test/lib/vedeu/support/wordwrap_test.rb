require 'test_helper'
require 'vedeu/support/wordwrap'

module Vedeu
  describe Wordwrap do
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

      it 'returns formatted text' do
        value =
       'Lorem ipsum dolor sit amet, consectetur adipiscing elit. '   \
       "Curabitur aliquet turpis id dui condimentum elementum.\n"    \
       'Pellentesque blandit vulputate imperdiet. Quisque ut arcu '  \
       "dolor. Morbi nec vulputate purus.\n\nQuisque porta feugiat " \
       'egestas. Aenean ac ipsum varius, lobortis lacus at, mattis ' \
       "est.\nQuisque viverra facilisis tortor, id convallis metus " \
       'laoreet quis. Curabitur auctor nunc blandit enim volutpat '  \
       'hendrerit. Phasellus accumsan tempor iaculis. Ut in semper ' \
       "massa. Cras quis viverra elit.\n\nInteger vitae mattis est." \
       ' Cras id nisl porttitor lectus placerat gravida sit amet '   \
       "quis diam.\n\nDonec mollis, nisi sit amet congue sagittis, " \
       'sapien magna rhoncus justo, vel molestie metus sapien eget ' \
       "libero.\n\n\n"
        Wordwrap.this(value, {}).must_equal(formatted_value)
      end

      it 'returns formatted text when the content should be pruned' do
        value  = 'Lorem ipsum dolor sit amet, consectetur ' \
                 'adipiscing elit. Curabitur aviverra facil tortor.'
        result = 'Lorem ipsum dolor sit amet, consectetur ' \
                 'adipiscing elit. Curabitur a...'
        Wordwrap.this(value, { width: 70, prune: true })
          .must_equal(result)
      end

      it 'returns formatted text when the content is less than the prune size' do
        Wordwrap.this('Wordwrap.this', { width: 70, prune: true })
          .must_equal('Wordwrap.this')
      end
    end
  end
end
