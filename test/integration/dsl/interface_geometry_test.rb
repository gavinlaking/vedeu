require 'test_helper'
describe 'Interface Geometry' do

  describe '#centred' do
    subject {
      Vedeu.interface 'geometry' do
        geometry do
          centred ''
        end
      end
    }

    it 'allows the use of centred within geometry' do
      skip
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

    it 'allows the use of height within geometry' do
      skip
    end
  end

  describe '#name' do
    subject {
      Vedeu.interface 'geometry' do
        geometry do
          name ''
        end
      end
    }

    it 'allows the use of name within geometry' do
      skip
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

    it 'allows the use of width within geometry' do
      skip
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

    it 'allows the use of x within geometry' do
      skip
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

    it 'allows the use of y within geometry' do
      skip
    end
  end

end
