require 'test_helper'

module Vedeu
  describe ContentArea do
    let(:interface) {
      Interface.new({
        name:     'titanium',
        geometry: {
          width:  40,
          height: 4,
        },
        lines: lines
      })
    }
    let(:lines) {
      [
        {
          streams: [{ text: 'Titanium is a chemical element.' }]
        }, {
          streams: { text: '' }
        }, {
          streams: [
            { text: 'It is a lustrous ' },
            { text: 'transition metal '  },
            { text: 'with a silver colour.' }
          ]
        }, {
          streams: { text: '' }
        }, {
          streams: [{ text: 'It has low density and high strength.' }]
        }
      ]
    }

    describe '#initialize' do
      it 'returns an instance of ContentArea' do
        ContentArea.new(interface).must_be_instance_of(ContentArea)
      end
    end

    describe '#geometry' do
      subject { ContentArea.new(interface).geometry }

      it 'returns an instance of Area' do
        subject.must_be_instance_of(Area)
      end

      context 'when there is content' do
        it 'uses the number of lines as the height' do
          subject.y_max.must_equal(5)
        end

        it 'uses the width of the longest line as the width' do
          subject.x_max.must_equal(55)
        end

        context 'when there are less lines than the height of the interface' do
          let(:lines) { [{}, {}] }

          it 'uses the height of the interface' do
            subject.y_max.must_equal(4)
          end
        end

        context 'when the lines have no streams or the line length is less ' \
                'than the interface width' do
          let(:lines) {
            [
              { streams: [] }
            ]
          }

          it 'uses the width of the interface' do
            subject.x_max.must_equal(40)
          end
        end
      end

      context 'when there is no content' do
        let(:lines) { [] }

        it 'uses the height of the interface' do
          subject.y_max.must_equal(4)
        end

        it 'uses the width of the interface' do
          subject.x_max.must_equal(40)
        end
      end
    end

  end
end
