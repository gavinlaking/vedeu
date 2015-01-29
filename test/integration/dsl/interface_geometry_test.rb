require 'test_helper'

describe 'Interface Geometry' do

  before do
    Vedeu.interfaces.reset
  end

  describe '#centred' do
    subject {
      Vedeu.interface 'geometry' do
        geometry do
          centred false
        end
      end
    }

    it { subject.must_be_instance_of(Vedeu::Interface) }

    it 'allows the use of centred within geometry' do
      subject.geometry.centred.must_equal(false)
    end

    context 'when no value is given' do
      subject {
        Vedeu.interface 'geometry' do
          geometry do
            centred
          end
        end
      }

      it { subject.geometry.centred.must_equal(true) }
    end
  end

  describe '#height' do
    subject {
      Vedeu.interface 'geometry' do
        geometry do
          height 17
        end
      end
    }

    it { subject.must_be_instance_of(Vedeu::Interface) }

    it 'allows the use of height within geometry' do
      subject.geometry.height.must_equal(17)
    end
  end

  describe '#name' do
    subject {
      Vedeu.interface 'geometry' do
        geometry do
          name 'other_name'
        end
      end
    }

    it { subject.must_be_instance_of(Vedeu::Interface) }

    it 'allows the use of name within geometry' do
      subject.geometry.name.must_equal('other_name')
    end
  end

  describe '#width' do
    subject {
      Vedeu.interface 'geometry' do
        geometry do
          width 29
        end
      end
    }

    it { subject.must_be_instance_of(Vedeu::Interface) }

    it 'allows the use of width within geometry' do
      subject.geometry.width.must_equal(29)
    end
  end

  describe '#x' do
    subject {
      Vedeu.interface 'geometry' do
        geometry do
          x 7
        end
      end
    }

    it { subject.must_be_instance_of(Vedeu::Interface) }

    it 'allows the use of x within geometry' do
      subject.geometry.x.must_equal(7)
    end

    context 'when no value is given' do
      subject {
        Vedeu.interface 'geometry' do
          geometry do
            x
          end
        end
      }

      it { subject.geometry.x.must_equal(0) }
    end

    context 'when a block is given' do
    end
  end

  describe '#y' do
    subject {
      Vedeu.interface 'geometry' do
        geometry do
          y 4
        end
      end
    }

    it { subject.must_be_instance_of(Vedeu::Interface) }

    it 'allows the use of y within geometry' do
      subject.geometry.y.must_equal(4)
    end

    context 'when no value is given' do
      subject {
        Vedeu.interface 'geometry' do
          geometry do
            y
          end
        end
      }

      it { subject.geometry.y.must_equal(0) }
    end

    context 'when a block is given' do
    end
  end

end
