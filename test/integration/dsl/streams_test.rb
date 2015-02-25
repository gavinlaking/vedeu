require 'test_helper'

describe 'Streams' do

  describe '#align' do
    subject {
      Vedeu.interface 'streams' do
        lines do
          streams do
            align 'Some text...'
          end
        end
      end
    }

    context 'when no value is provided' do

    end
  end

  describe '#background' do
    subject {
      Vedeu.interface 'streams' do
        lines do
          streams do
            background ''
          end
        end
      end
    }

    context 'when no value is provided' do

    end
  end

  describe '#colour' do
    subject {
      Vedeu.interface 'streams' do
        lines do
          streams do
            colour ''
          end
        end
      end
    }

    context 'when no value is provided' do

    end
  end

  describe '#foreground' do
    subject {
      Vedeu.interface 'streams' do
        lines do
          streams do
            foreground ''
          end
        end
      end
    }

    context 'when no value is provided' do

    end
  end

  describe '#style' do
    let(:value) { '' }

    subject {
      Vedeu.interface 'lines' do
        lines do
          streams do
            style value
          end
        end
      end
    }

    context 'when no value is provided' do
      let(:value) {}
    end
  end

  describe '#text' do
    subject {
      Vedeu.interface 'streams' do
        lines do
          streams do
            text 'Some text...'
          end
        end
      end
    }

    context 'when no value is provided' do

    end
  end

end
