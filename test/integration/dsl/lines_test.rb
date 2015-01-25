require 'test_helper'

describe 'Lines' do

  describe '#background' do
    subject {
      Vedeu.interface 'lines' do
        lines do
          background ''
        end
      end
    }

    #it { subject.must_be_instance_of(Vedeu::Line) }

    it 'allows the use of background within lines' do
      skip
    end

    context 'when no value is provided' do

    end
  end

  describe '#colour' do
    subject {
      Vedeu.interface 'lines' do
        lines do
          colour ''
        end
      end
    }

    #it { subject.must_be_instance_of(Vedeu::Line) }

    it 'allows the use of colour within lines' do
      skip
    end

    context 'when no value is provided' do

    end
  end

  describe '#foreground' do
    subject {
      Vedeu.interface 'lines' do
        lines do
          foreground ''
        end
      end
    }

    #it { subject.must_be_instance_of(Vedeu::Line) }

    it 'allows the use of foreground within lines' do
      skip
    end

    context 'when no value is provided' do

    end
  end

  describe '#line' do
    subject {
      Vedeu.interface 'lines' do
        lines do
          line ''
        end
      end
    }

    #it { subject.must_be_instance_of(Vedeu::Line) }

    it 'allows the use of line within lines' do
      skip
    end

    context 'when no value is provided' do

    end
  end

  describe '#stream' do
    subject {
      Vedeu.interface 'lines' do
        lines do
          stream ''
        end
      end
    }

    #it { subject.must_be_instance_of(Vedeu::Line) }

    it 'allows the use of stream within lines' do
      skip
    end

    context 'when no value is provided' do

    end
  end

  describe '#streams' do
    subject {
      Vedeu.interface 'lines' do
        lines do
          streams do
          end
        end
      end
    }

    #it { subject.must_be_instance_of(Vedeu::Line) }

    it 'allows the use of streams within lines' do
      skip
    end

    context 'when no value is provided' do

    end
  end

  describe '#style' do
    subject {
      Vedeu.interface 'lines' do
        lines do
          style ''
        end
      end
    }

    #it { subject.must_be_instance_of(Vedeu::Line) }

    it 'allows the use of style within lines' do
      skip
    end

    context 'when no value is provided' do

    end
  end

end
