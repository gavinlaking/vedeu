require 'test_helper'

module Vedeu

  module CLI

    describe Main do

      let(:described) { Vedeu::CLI::Main }
      let(:instance)  { described.new }

      describe '#new' do
        let(:_name) { 'app_name' }

        before {
          instance.stubs(:say)
          Vedeu::Generator::Application.stubs(:generate).returns('')
        }

        subject { instance.new(_name) }

        it {
          Vedeu::Generator::Application.expects(:generate).with(_name)
          subject
        }
      end

      describe '#view' do
        let(:_name) { 'view_name' }

        before {
          instance.stubs(:say)
          Vedeu::Generator::View.stubs(:generate).returns('')
        }

        subject { instance.view(_name) }

        it {
          Vedeu::Generator::View.expects(:generate).with(_name)
          subject
        }
      end

      describe '#version' do
        before { instance.stubs(:say) }

        subject { instance.version }

        it {
          instance.expects(:say).with("vedeu #{Vedeu::VERSION}")
          subject
        }
      end

    end # Main

  end # CLI

end # Vedeu
