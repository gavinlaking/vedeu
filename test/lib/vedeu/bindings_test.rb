require 'test_helper'

module Vedeu

  describe Bindings do

    let(:described) { Vedeu::Bindings }

    describe '.setup!' do
      before do
        Vedeu::Bindings::Application.stubs(:setup!)
        Vedeu::Bindings::Visibility.stubs(:setup!)
        Vedeu::Bindings::Movement.stubs(:setup!)
        Vedeu::Bindings::Menus.stubs(:setup!)
        Vedeu::Bindings::DRB.stubs(:setup!)
        Vedeu::Bindings::System.stubs(:setup!)
      end

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

      it { subject.must_equal(true) }
    end

  end # Bindings

end # Vedeu
