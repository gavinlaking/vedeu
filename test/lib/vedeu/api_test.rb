require 'test_helper'

module Vedeu

  describe API do

    describe 'Forwardable' do

      describe 'Vedeu::BackgroundColours' do
        describe '.background_colours' do
          subject { Vedeu.background_colours }

          # it { subject.must_be_instance_of(Vedeu::BackgroundColours) }
        end
      end

      describe 'Vedeu::Borders' do
        describe '.borders' do
          subject { Vedeu.borders }

          it { subject.must_be_instance_of(Vedeu::Borders) }
        end
      end

      describe 'Vedeu::Buffers' do
        describe '.buffers' do
          subject { Vedeu.buffers }

          it { subject.must_be_instance_of(Vedeu::Buffers) }
        end
      end

      describe 'Vedeu::Canvas' do
        describe '.canvas' do
          subject { Vedeu.canvas }

          it { subject.must_be_instance_of(Vedeu::Canvas) }
        end
      end

      describe 'Vedeu::Configuration' do
        describe '.configure' do
          subject { Vedeu.configure }

          # it { subject.must_be_instance_of(NilClass) }
        end

        describe '.configuration' do
          subject { Vedeu.configuration }

          it { subject.must_be_instance_of(Vedeu::Configuration) }
        end
      end

      describe 'Vedeu::Cursors' do
        describe '.cursor' do
          subject { Vedeu.cursor }

          # when all tests run
          # it { subject.must_be_instance_of(Vedeu::Cursor) }

          # when just this test runs
          # it { subject.must_be_instance_of(NilClass) }
        end

        describe '.cursors' do
          subject { Vedeu.cursors }

          it { subject.must_be_instance_of(Vedeu::Cursors) }
        end
      end

      describe 'Vedeu::DSL::Border' do
        describe '.border' do
          let(:arg) {}

          subject { Vedeu.border(arg) {} }

          # it { subject.must_be_instance_of(NilClass) }
        end
      end

      describe 'Vedeu::DSL::Geometry' do
        describe '.geometry' do
          let(:arg) {}

          subject { Vedeu.geometry(arg) { } }

          # it { subject.must_be_instance_of(NilClass) }
        end
      end

      describe 'Vedeu::DSL::Group' do
        describe '.group' do
          let(:arg) {}

          subject { Vedeu.group(arg) { } }

          # it { subject.must_be_instance_of(NilClass) }
        end
      end

      describe 'Vedeu::DSL::Keymap' do
        describe '.keymap' do
          let(:arg) {}

          subject { Vedeu.keymap(arg) }

          # it { subject.must_be_instance_of(NilClass) }
        end
      end

      describe 'Vedeu::DSL::View' do
        describe '.interface' do
          subject { Vedeu.interface { } }

          # it { subject.must_be_instance_of(NilClass) }
        end

        describe '.renders' do
          subject { Vedeu.renders { } }

          # it { subject.must_be_instance_of(Array) }
        end

        describe '.views' do
          subject { Vedeu.views { } }

          # it { subject.must_be_instance_of(Array) }
        end
      end

      describe 'Vedeu::Event' do
        describe '.bind' do
          let(:args) {}

          subject { Vedeu.bind(args) }

          # it { subject.must_be_instance_of(NilClass) }
        end

        describe '.unbind' do
          let(:args) {}

          subject { Vedeu.unbind(args) }

          # it { subject.must_be_instance_of(FalseClass) }
        end
      end

      describe 'Vedeu::EventsRepository' do
        describe '.events' do
          subject { Vedeu.events }

          it { subject.must_be_instance_of(Vedeu::EventsRepository) }
        end
      end

      describe 'Vedeu::Focus' do
        describe '.focus' do
          subject { Vedeu.focus }

          # it { subject.must_be_instance_of(NilClass) }
        end

        describe '.focus_by_name' do
          let(:_name) {}

          subject { Vedeu.focus_by_name(_name) }

          # it { subject.must_be_instance_of(NilClass) }
        end

        describe '.focussed?' do
          let(:arg) {}

          subject { Vedeu.focussed?(arg) }

          # it { subject.must_be_instance_of(TrueClass) }
        end

        describe '.focus_next' do
          subject { Vedeu.focus_next }

          # it { subject.must_be_instance_of(FalseClass) }
        end

        describe '.focus_previous' do
          subject { Vedeu.focus_previous }

          # it { subject.must_be_instance_of(FalseClass) }
        end
      end

      describe 'Vedeu::ForegroundColours' do
        describe '.foreground_colours' do
          subject { Vedeu.foreground_colours }

          # it { subject.must_be_instance_of(Vedeu::ForegroundColours) }
        end
      end

      describe 'Vedeu::Geometries' do
        describe '.geometries' do
          subject { Vedeu.geometries }

          it { subject.must_be_instance_of(Vedeu::Geometries) }
        end
      end

      describe 'Vedeu::Groups' do
        describe '.groups' do
          subject { Vedeu.groups }

          it { subject.must_be_instance_of(Vedeu::Groups) }
        end
      end

      describe 'Vedeu::InterfacesRepository' do
        describe '.interfaces' do
          subject { Vedeu.interfaces }

          it { subject.must_be_instance_of(Vedeu::InterfacesRepository) }
        end
      end

      describe 'Vedeu::Keymaps' do
        describe '.keymaps' do
          subject { Vedeu.keymaps }

          it { subject.must_be_instance_of(Vedeu::Keymaps) }
        end
      end

      describe 'Vedeu::Log' do
        describe '.log' do
          subject { Vedeu.log(message: '') }

          # it { subject.must_be_instance_of(NilClass) }
        end
      end

      describe 'Vedeu::Mapper' do
        describe '.keypress' do
          subject { Vedeu.keypress }

          # it { subject.must_be_instance_of(FalseClass) }
        end
      end

      describe 'Vedeu::Menu' do
        describe '.menu' do
          subject { Vedeu.menu { } }

          # it { subject.must_be_instance_of(NilClass) }
        end
      end

      describe 'Vedeu::Menus' do
        describe '.menus' do
          subject { Vedeu.menus }

          it { subject.must_be_instance_of(Vedeu::Menus) }
        end
      end

      describe 'Vedeu::Renderers' do
        describe '.renderer' do
          subject { Vedeu.renderer }

          # it { subject.must_be_instance_of(Set) }
        end

        describe '.renderers' do
          subject { Vedeu.renderers }

          # it { subject.must_be_instance_of(Module) }
        end
      end

      describe 'Vedeu::Terminal' do
        describe '.height' do
          subject { Vedeu.height }

          # it { subject.must_be_instance_of(Fixnum) }
        end

        describe '.width' do
          subject { Vedeu.width }

          # it { subject.must_be_instance_of(Fixnum) }
        end

        describe '.resize' do
          subject { Vedeu.resize }

          # it { subject.must_be_instance_of(TrueClass) }
        end
      end

      describe 'Vedeu::Trigger' do
        describe '.trigger' do
          let(:args) {}

          subject { Vedeu.trigger(args) }

          # it { subject.must_be_instance_of(Array) }
        end
      end

    end

  end # API

end # Vedeu
