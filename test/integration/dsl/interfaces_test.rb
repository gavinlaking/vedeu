require 'test_helper'

describe 'Interfaces' do

  describe '#background' do
    subject {
      Vedeu.interface 'interfaces' do
        background ''
      end
    }

    it { return_type_for(subject, Vedeu::Interface) }

    it 'allows the use of background within Vedeu.interface' do
      skip
    end

    context 'when no value is provided' do

    end
  end

  describe '#border' do
    subject {
      Vedeu.interface 'interfaces' do
        border do
        end
      end
    }

    it { return_type_for(subject, Vedeu::Interface) }

    it 'allows the use of border within Vedeu.interface' do
      skip
    end

    context 'when no value is provided' do

    end
  end

  describe '#colour' do
    subject {
      Vedeu.interface 'interfaces' do
        colour ''
      end
    }

    #it { return_type_for(subject, Vedeu::Interface) }

    it 'allows the use of colour within Vedeu.interface' do
      skip
    end

    context 'when no value is provided' do

    end
  end

  describe '#foreground' do
    subject {
      Vedeu.interface 'interfaces' do
        foreground ''
      end
    }

    it { return_type_for(subject, Vedeu::Interface) }

    it 'allows the use of foreground within Vedeu.interface' do
      skip
    end

    context 'when no value is provided' do

    end
  end

  describe '#cursor' do
    subject {
      Vedeu.interface 'interfaces' do
        cursor ''
      end
    }

    #it { return_type_for(subject, Vedeu::Interface) }

    it 'allows the use of cursor within Vedeu.interface' do
      skip
    end

    context 'when no value is provided' do

    end
  end

  describe '#cursor!' do
    subject {
      Vedeu.interface 'interfaces' do
        cursor!
      end
    }

    #it { return_type_for(subject, Vedeu::Interface) }

    it 'allows the use of cursor! within Vedeu.interface' do
      skip
    end

    context 'when no value is provided' do

    end
  end

  describe '#delay' do
    subject {
      Vedeu.interface 'interfaces' do
        delay ''
      end
    }

    it { return_type_for(subject, Vedeu::Interface) }

    it 'allows the use of delay within Vedeu.interface' do
      skip
    end

    context 'when no value is provided' do

    end
  end

  describe '#focus!' do
    subject {
      Vedeu.interface 'interfaces' do
        focus!
      end
    }

    #it { return_type_for(subject, Vedeu::Interface) }

    it 'allows the use of focus! within Vedeu.interface' do
      skip
    end

    context 'when no value is provided' do

    end
  end

  describe '#geometry' do
    subject {
      Vedeu.interface 'interfaces' do
        geometry do
        end
      end
    }

    it { return_type_for(subject, Vedeu::Interface) }

    it 'allows the use of geometry within Vedeu.interface' do
      skip
    end

    context 'when no value is provided' do

    end
  end

  describe '#group' do
    subject {
      Vedeu.interface 'interfaces' do
        group ''
      end
    }

    it { return_type_for(subject, Vedeu::Interface) }

    it 'allows the use of group within Vedeu.interface' do
      skip
    end

    context 'when no value is provided' do

    end
  end

  describe '#keys' do
    subject {
      Vedeu.interface 'interfaces' do
        keys do
        end
      end
    }

    #it { return_type_for(subject, Vedeu::Interface) }

    it 'allows the use of keys within Vedeu.interface' do
      skip
    end

    context 'when no value is provided' do

    end
  end

  describe '#lines' do
    subject {
      Vedeu.interface 'interfaces' do
        lines do
        end
      end
    }

    #it { return_type_for(subject, Vedeu::Interface) }

    it 'allows the use of lines within Vedeu.interface' do
      skip
    end

    context 'when no value is provided' do

    end
  end

  describe '#name' do
    subject {
      Vedeu.interface 'interfaces' do
        name ''
      end
    }

    it { return_type_for(subject, Vedeu::Interface) }

    it 'allows the use of name within Vedeu.interface' do
      skip
    end

    context 'when no value is provided' do

    end
  end

  describe '#style' do
    subject {
      Vedeu.interface 'interfaces' do
        style ''
      end
    }

    it { return_type_for(subject, Vedeu::Interface) }

    it 'allows the use of style within Vedeu.interface' do
      skip
    end

    context 'when no value is provided' do

    end
  end

  describe 'Deprecated' do
    describe '#centred' do
      subject {
        Vedeu.interface 'interfaces' do
          centred true
        end
      }

      it 'disallows the use of centred within Vedeu.interface' do
        proc { subject }.must_raise(Vedeu::DeprecationError)
      end
    end

    describe '#height' do
      subject {
        Vedeu.interface 'interfaces' do
          height 5
        end
      }

      it 'disallows the use of height within Vedeu.interface' do
        proc { subject }.must_raise(Vedeu::DeprecationError)
      end
    end

    describe '#line' do
      subject {
        Vedeu.interface 'interfaces' do
          line 'Some text'
        end
      }

      it 'disallows the use of line within Vedeu.interface' do
        proc { subject }.must_raise(Vedeu::DeprecationError)
      end
    end

    describe '#width' do
      subject {
        Vedeu.interface 'interfaces' do
          width 10
        end
      }

      it 'disallows the use of width within Vedeu.interface' do
        proc { subject }.must_raise(Vedeu::DeprecationError)
      end
    end

    describe '#x' do
      subject {
        Vedeu.interface 'interfaces' do
          x 14
        end
      }

      it 'disallows the use of x within Vedeu.interface' do
        proc { subject }.must_raise(Vedeu::DeprecationError)
      end
    end

    describe '#y' do
      subject {
        Vedeu.interface 'interfaces' do
          y 12
        end
      }

      it 'disallows the use of y within Vedeu.interface' do
        proc { subject }.must_raise(Vedeu::DeprecationError)
      end
    end
  end

end
