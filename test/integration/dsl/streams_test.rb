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

    it 'allows the use of align within stream(s)' do
      skip
      subject.must_equal('Some text')
    end

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

    it 'allows the use of background within stream(s)' do
      skip
    end

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

    it 'allows the use of colour within stream(s)' do
      skip
    end

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

    it 'allows the use of foreground within stream(s)' do
      skip
    end

    context 'when no value is provided' do

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

    it 'allows the use of text within stream(s)' do
      skip
      subject.must_equal('Some text...')
    end

    context 'when no value is provided' do

    end
  end

  describe 'Deprecated' do
    describe '#width' do
      subject {
        Vedeu.interface 'streams' do
          lines do
            streams do
              width 20
            end
          end
        end
      }

      it 'disallows the use of width within stream(s)' do
        proc { subject }.must_raise(Vedeu::DeprecationError)
      end
    end
  end

end
