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

    #it { subject.must_be_instance_of(Vedeu::Composition) }

    # it 'allows the use of Vedeu.view' do
    #   skip
    # end

    context 'when no block is given' do
      subject { Vedeu.view }

      #it { proc { subject }.must_raise(Vedeu::InvalidSyntax) }
    end
  end

end
