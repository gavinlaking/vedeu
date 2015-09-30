require 'test_helper'

module Vedeu

  describe Bindings do

    let(:described) { Vedeu::Bindings }

    describe '.setup!' do
      before do
        Vedeu::Events::Repository.stubs(:reset!)

        Vedeu::Bindings::Application.stubs(:setup!)
        Vedeu::Bindings::Document.stubs(:setup!)
        Vedeu::Bindings::DRB.stubs(:setup!)
        Vedeu::Bindings::Focus.stubs(:setup!)
        Vedeu::Bindings::Menus.stubs(:setup!)
        Vedeu::Bindings::Movement.stubs(:setup!)
        Vedeu::Bindings::Refresh.stubs(:setup!)
        Vedeu::Bindings::System.stubs(:setup!)
        Vedeu::Bindings::View.stubs(:setup!)
        Vedeu::Bindings::Visibility.stubs(:setup!)
      end

      subject { described.setup! }

      it {
        Vedeu::Bindings::Application.expects(:setup!)
        subject
      }

      it {
        Vedeu::Bindings::Document.expects(:setup!)
        subject
      }

      it {
        Vedeu::Bindings::DRB.expects(:setup!)
        subject
      }

      it {
        Vedeu::Bindings::Focus.expects(:setup!)
        subject
      }

      it {
        Vedeu::Bindings::Menus.expects(:setup!)
        subject
      }

      it {
        Vedeu::Bindings::Movement.expects(:setup!)
        subject
      }

      it {
        Vedeu::Bindings::Refresh.expects(:setup!)
        subject
      }

      it {
        Vedeu::Bindings::System.expects(:setup!)
        subject
      }

      it {
        Vedeu::Bindings::View.expects(:setup!)
        subject
      }

      it {
        Vedeu::Bindings::Visibility.expects(:setup!)
        subject
      }

      it { subject.must_equal(true) }
    end

    describe '.setup_aliases!' do
      before do
        Vedeu::Bindings::Application.stubs(:setup_aliases!)
        Vedeu::Bindings::Movement.stubs(:setup_aliases!)
        Vedeu::Bindings::Visibility.stubs(:setup_aliases!)
      end

      subject { described.setup_aliases! }

      it {
        Vedeu::Bindings::Application.expects(:setup_aliases!)
        subject
      }

      it {
        Vedeu::Bindings::Movement.expects(:setup_aliases!)
        subject
      }

      it {
        Vedeu::Bindings::Visibility.expects(:setup_aliases!)
        subject
      }

      it { subject.must_equal(true) }
    end

  end # Bindings

end # Vedeu
