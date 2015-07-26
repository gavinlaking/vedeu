require 'test_helper'

module Vedeu

	describe Bindings do

    let(:described) { Vedeu::Bindings }

    describe '.setup!' do
      subject { described.setup! }

      it {
        Vedeu::Bindings::Application.expects(:setup!)
        subject
      }

      it {
        Vedeu::Bindings::Visibility.expects(:setup!)
        subject
      }

      it {
        Vedeu::Bindings::Movement.expects(:setup!)
        subject
      }

      it {
        Vedeu::Bindings::Menus.expects(:setup!)
        subject
      }

      it {
        Vedeu::Bindings::DRB.expects(:setup!)
        subject
      }

      it {
        Vedeu::Bindings::System.expects(:setup!)
        subject
      }
    end

	end # Bindings

end # Vedeu
