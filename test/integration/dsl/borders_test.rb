require 'test_helper'

describe 'Interface Borders' do

  before do
    Vedeu.interfaces.reset
    Vedeu.interface 'borders' do
      geometry do
        height 3
        width  3
      end
      lines do
        line ''
      end
    end
  end

  describe '#bottom_left' do
    subject {
      Vedeu.interface 'borders' do
        border do
          bottom_left '<'
        end
      end
    }

    it { subject.must_be_instance_of(Vedeu::Interface) }

    it 'allows the use of bottom_left within border' do
      subject.border.to_s.must_equal(
        "\e(0l\e(B\e(0q\e(B\e(0k\e(B\n" \
        "\e(0x\e(B \e(0x\e(B\n" \
        "\e(0<\e(B\e(0q\e(B\e(0j\e(B"
      )
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

    it { subject.must_be_instance_of(Vedeu::Interface) }

    it 'allows the use of bottom_right within border' do
      subject.border.to_s.must_equal(
        "\e(0l\e(B\e(0q\e(B\e(0k\e(B\n" \
        "\e(0x\e(B \e(0x\e(B\n" \
        "\e(0m\e(B\e(0q\e(B\e(0>\e(B"
      )
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

    it { subject.must_be_instance_of(Vedeu::Interface) }

    it 'allows the use of horizontal within border' do
      subject.border.to_s.must_equal(
        "\e(0l\e(B\e(0~\e(B\e(0k\e(B\n" \
        "\e(0x\e(B \e(0x\e(B\n" \
        "\e(0m\e(B\e(0~\e(B\e(0j\e(B"
      )
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

    it { subject.must_be_instance_of(Vedeu::Interface) }

    it 'allows the use of show_bottom within border' do
      subject.border.to_s.must_equal(
        "\e(0l\e(B\e(0q\e(B\e(0k\e(B\n" \
        "\e(0x\e(B \e(0x\e(B\n" \
        "\e(0m\e(B\e(0q\e(B\e(0j\e(B"
      )
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

    it { subject.must_be_instance_of(Vedeu::Interface) }

    it 'allows the use of show_left within border' do
      subject.border.to_s.must_equal(
        "\e(0l\e(B\e(0q\e(B\e(0k\e(B\n" \
        "\e(0x\e(B \e(0x\e(B\n" \
        "\e(0m\e(B\e(0q\e(B\e(0j\e(B"
      )
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

    it { subject.must_be_instance_of(Vedeu::Interface) }

    it 'allows the use of show_right within border' do
      subject.border.to_s.must_equal(
        "\e(0l\e(B\e(0q\e(B\e(0k\e(B\n" \
        "\e(0x\e(B \e(0x\e(B\n" \
        "\e(0m\e(B\e(0q\e(B\e(0j\e(B"
      )
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

    it { subject.must_be_instance_of(Vedeu::Interface) }

    it 'allows the use of show_top within border' do
      subject.border.to_s.must_equal(
        "\e(0l\e(B\e(0q\e(B\e(0k\e(B\n" \
        "\e(0x\e(B \e(0x\e(B\n" \
        "\e(0m\e(B\e(0q\e(B\e(0j\e(B"
      )
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

    it { subject.must_be_instance_of(Vedeu::Interface) }

    it 'allows the use of top_left within border' do
      subject.border.to_s.must_equal(
        "\e(0{\e(B\e(0q\e(B\e(0k\e(B\n" \
        "\e(0x\e(B \e(0x\e(B\n" \
        "\e(0m\e(B\e(0q\e(B\e(0j\e(B"
      )
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

    it { subject.must_be_instance_of(Vedeu::Interface) }

    it 'allows the use of top_right within border' do
      subject.border.to_s.must_equal(
        "\e(0l\e(B\e(0q\e(B\e(0}\e(B\n" \
        "\e(0x\e(B \e(0x\e(B\n" \
        "\e(0m\e(B\e(0q\e(B\e(0j\e(B"
      )
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

    it { subject.must_be_instance_of(Vedeu::Interface) }

    it 'allows the use of vertical within border' do
      subject.border.to_s.must_equal(
        "\e(0l\e(B\e(0q\e(B\e(0k\e(B\n" \
        "\e(0:\e(B \e(0:\e(B\n" \
        "\e(0m\e(B\e(0q\e(B\e(0j\e(B"
      )
    end
  end

end
