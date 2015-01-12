require 'test_helper'

describe 'Interface Borders' do

  describe '#bottom_left' do
    subject {
      Vedeu.interface 'borders' do
        border do
          bottom_left '<'
        end
      end
    }

    it { return_type_for(subject, Vedeu::Interface) }

    it 'allows the use of bottom_left within border' do
      skip
    end
  end

  describe '#bottom_right' do
    subject {
      Vedeu.interface 'borders' do
        border do
          bottom_right '>'
        end
      end
    }

    it { return_type_for(subject, Vedeu::Interface) }

    it 'allows the use of bottom_right within border' do
      skip
    end
  end

  describe '#horizontal' do
    subject {
      Vedeu.interface 'borders' do
        border do
          horizontal '~'
        end
      end
    }

    it { return_type_for(subject, Vedeu::Interface) }

    it 'allows the use of horizontal within border' do
      skip
    end
  end

  describe '#show_bottom' do
    subject {
      Vedeu.interface 'borders' do
        border do
          show_bottom ''
        end
      end
    }

    it { return_type_for(subject, Vedeu::Interface) }

    it 'allows the use of show_bottom within border' do
      skip
    end
  end

  describe '#show_left' do
    subject {
      Vedeu.interface 'borders' do
        border do
          show_left ''
        end
      end
    }

    it { return_type_for(subject, Vedeu::Interface) }

    it 'allows the use of show_left within border' do
      skip
    end
  end

  describe '#show_right' do
    subject {
      Vedeu.interface 'borders' do
        border do
          show_right ''
        end
      end
    }

    it { return_type_for(subject, Vedeu::Interface) }

    it 'allows the use of show_right within border' do
      skip
    end
  end

  describe '#show_top' do
    subject {
      Vedeu.interface 'borders' do
        border do
          show_top ''
        end
      end
    }

    it { return_type_for(subject, Vedeu::Interface) }

    it 'allows the use of show_top within border' do
      skip
    end
  end

  describe '#top_left' do
    subject {
      Vedeu.interface 'borders' do
        border do
          top_left '{'
        end
      end
    }

    it { return_type_for(subject, Vedeu::Interface) }

    it 'allows the use of top_left within border' do
      skip
    end
  end

  describe '#top_right' do
    subject {
      Vedeu.interface 'borders' do
        border do
          top_right '}'
        end
      end
    }

    it { return_type_for(subject, Vedeu::Interface) }

    it 'allows the use of top_right within border' do
      skip
    end
  end

  describe '#vertical' do
    subject {
      Vedeu.interface 'borders' do
        border do
          vertical ':'
        end
      end
    }

    it { return_type_for(subject, Vedeu::Interface) }

    it 'allows the use of vertical within border' do
      skip
    end
  end

end
