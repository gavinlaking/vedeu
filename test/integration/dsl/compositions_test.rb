require 'test_helper'

describe 'Compositions' do

  describe '#view' do
    subject {
      Vedeu.views do
        view 'compositions' do
          # ...
        end
      end
    }

    context 'when no block is given' do
      subject { Vedeu.view }
    end
  end

end
