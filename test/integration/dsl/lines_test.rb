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

    context 'when no value is provided' do

    end
  end

end
