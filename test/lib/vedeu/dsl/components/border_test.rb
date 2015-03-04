require 'test_helper'

module Vedeu

  module DSL

    describe Border do

      let(:described)  { Vedeu::DSL::Border }
      let(:instance)   { described.new(model, client) }
      let(:model)      { Vedeu::Border.new(attributes) }
      let(:client)     {}
      let(:attributes) { { name: 'borders' } }
      let(:boolean)    { true }

      before do
        Vedeu.borders.reset
        Vedeu.buffers.reset
        Vedeu.interfaces.reset
        Vedeu.interface 'borders' do
          geometry do
            height 3
            width  3
          end
          lines do
            line ''
          end
        end
      end

      describe 'alias methods' do
        it { instance.must_respond_to(:show_bottom) }
        it { instance.must_respond_to(:show_left) }
        it { instance.must_respond_to(:show_right) }
        it { instance.must_respond_to(:show_top) }
      end

      describe '#initialize' do
        it { instance.must_be_instance_of(Vedeu::DSL::Border) }
        it { instance.instance_variable_get('@model').must_equal(model) }
        it { instance.instance_variable_get('@client').must_equal(client) }
      end

      describe '#bottom_left' do
        let(:char) { 'C' }

        subject { instance.bottom_left(char) }

        it { subject.must_be_instance_of(String) }
        it { subject.must_equal('C') }

        context 'DSL #bottom_left' do
          subject {
            Vedeu.interface 'borders' do
              border do
                bottom_left '<'
              end
              geometry do
                height 3
                width  3
              end
              lines do
                line ''
              end
            end
          }

          it { subject.must_be_instance_of(Vedeu::Interface) }

          it 'allows the use of bottom_left within border' do
            subject.border.to_s.must_equal(
              "\e(0l\e(B\e(0q\e(B\e(0k\e(B\n" \
              "\e(0x\e(B \e(0x\e(B\n" \
              "\e(0<\e(B\e(0q\e(B\e(0j\e(B"
            )
          end
        end
      end

      describe '#bottom_right' do
        let(:char) { 'D' }

        subject { instance.bottom_right(char) }

        it { subject.must_be_instance_of(String) }
        it { subject.must_equal('D') }

        context 'DSL #bottom_right' do
          subject {
            Vedeu.interface 'borders' do
              border do
                bottom_right '>'
              end
              geometry do
                height 3
                width  3
              end
              lines do
                line ''
              end
            end
          }

          it { subject.must_be_instance_of(Vedeu::Interface) }

          it 'allows the use of bottom_right within border' do
            subject.border.to_s.must_equal(
              "\e(0l\e(B\e(0q\e(B\e(0k\e(B\n" \
              "\e(0x\e(B \e(0x\e(B\n" \
              "\e(0m\e(B\e(0q\e(B\e(0>\e(B"
            )
          end
        end
      end

      describe '#horizontal' do
        let(:char) { 'H' }

        subject { instance.horizontal(char) }

        it { subject.must_be_instance_of(String) }
        it { subject.must_equal('H') }

        context 'DSL #horizontal' do
          subject {
            Vedeu.interface 'borders' do
              border do
                horizontal '~'
              end
              geometry do
                height 3
                width  3
              end
              lines do
                line ''
              end
            end
          }

          it { subject.must_be_instance_of(Vedeu::Interface) }

          it 'allows the use of horizontal within border' do
            subject.border.to_s.must_equal(
              "\e(0l\e(B\e(0~\e(B\e(0k\e(B\n" \
              "\e(0x\e(B \e(0x\e(B\n" \
              "\e(0m\e(B\e(0~\e(B\e(0j\e(B"
            )
          end
        end
      end

      describe '#show_bottom' do
        subject { instance.show_bottom(boolean) }

        it { subject.must_be_instance_of(TrueClass) }

        context 'when false' do
          let(:boolean) { false }

          it { subject.must_be_instance_of(FalseClass) }
        end

        context 'DSL #show_bottom' do
          subject {
            Vedeu.interface 'borders' do
              border do
                show_bottom ''
              end
              geometry do
                height 3
                width  3
              end
              lines do
                line ''
              end
            end
          }

          it { subject.must_be_instance_of(Vedeu::Interface) }

          it 'allows the use of show_bottom within border' do
            subject.border.to_s.must_equal(
              "\e(0l\e(B\e(0q\e(B\e(0k\e(B\n" \
              "\e(0x\e(B \e(0x\e(B\n" \
              "\e(0m\e(B\e(0q\e(B\e(0j\e(B"
            )
          end
        end

        it { instance.must_respond_to(:bottom) }
      end

      describe '#hide_bottom!' do
        subject { instance.hide_bottom! }

        it { subject.must_be_instance_of(FalseClass) }
      end

      describe '#show_bottom!' do
        subject { instance.show_bottom! }

        it { subject.must_be_instance_of(TrueClass) }
      end

      describe '#show_left' do
        subject { instance.show_left(boolean) }

        it { subject.must_be_instance_of(TrueClass) }

        it { instance.must_respond_to(:left) }

        context 'when false' do
          let(:boolean) { false }

          it { subject.must_be_instance_of(FalseClass) }
        end

        context 'DSL #show_left' do
          subject {
            Vedeu.interface 'borders' do
              border do
                show_left!
              end
              geometry do
                height 3
                width  3
              end
              lines do
                line ''
              end
            end
          }

          it { subject.must_be_instance_of(Vedeu::Interface) }

          it 'allows the use of show_left within border' do
            subject.border.to_s.must_equal(
              "\e(0l\e(B\e(0q\e(B\e(0k\e(B\n" \
              "\e(0x\e(B \e(0x\e(B\n" \
              "\e(0m\e(B\e(0q\e(B\e(0j\e(B"
            )
          end
        end
      end

      describe '#hide_left!' do
        subject { instance.hide_left! }

        it { subject.must_be_instance_of(FalseClass) }
      end

      describe '#show_left!' do
        subject { instance.show_left! }

        it { subject.must_be_instance_of(TrueClass) }
      end

      describe '#show_right' do
        subject { instance.show_right(boolean) }

        it { subject.must_be_instance_of(TrueClass) }

        it { instance.must_respond_to(:right) }

        context 'when false' do
          let(:boolean) { false }

          it { subject.must_be_instance_of(FalseClass) }
        end

        context 'DSL #show_right' do
          subject {
            Vedeu.interface 'borders' do
              border do
                show_right!
              end
              geometry do
                height 3
                width  3
              end
              lines do
                line ''
              end
            end
          }

          it { subject.must_be_instance_of(Vedeu::Interface) }

          it 'allows the use of show_right within border' do
            subject.border.to_s.must_equal(
              "\e(0l\e(B\e(0q\e(B\e(0k\e(B\n" \
              "\e(0x\e(B \e(0x\e(B\n" \
              "\e(0m\e(B\e(0q\e(B\e(0j\e(B"
            )
          end
        end
      end

      describe '#hide_right!' do
        subject { instance.hide_right! }

        it { subject.must_be_instance_of(FalseClass) }
      end

      describe '#show_right!' do
        subject { instance.show_right! }

        it { subject.must_be_instance_of(TrueClass) }
      end

      describe '#show_top' do
        subject { instance.show_top(boolean) }

        it { subject.must_be_instance_of(TrueClass) }

        it { instance.must_respond_to(:top) }

        context 'when false' do
          let(:boolean) { false }

          it { subject.must_be_instance_of(FalseClass) }
        end

        context 'DSL #show_top' do
          subject {
            Vedeu.interface 'borders' do
              border do
                show_top ''
              end
              geometry do
                height 3
                width  3
              end
              lines do
                line ''
              end
            end
          }

          it { subject.must_be_instance_of(Vedeu::Interface) }

          it 'allows the use of show_top within border' do
            subject.border.to_s.must_equal(
              "\e(0l\e(B\e(0q\e(B\e(0k\e(B\n" \
              "\e(0x\e(B \e(0x\e(B\n" \
              "\e(0m\e(B\e(0q\e(B\e(0j\e(B"
            )
          end
        end
      end

      describe '#hide_top!' do
        subject { instance.hide_top! }

        it { subject.must_be_instance_of(FalseClass) }
      end

      describe '#show_top!' do
        subject { instance.show_top! }

        it { subject.must_be_instance_of(TrueClass) }
      end

      describe '#top_left' do
        let(:char) { 'A' }

        subject { instance.top_left(char) }

        it { subject.must_be_instance_of(String) }
        it { subject.must_equal('A') }

        context 'DSL #top_left' do
          subject {
            Vedeu.interface 'borders' do
              border do
                top_left '{'
              end
              geometry do
                height 3
                width  3
              end
              lines do
                line ''
              end
            end
          }

          it { subject.must_be_instance_of(Vedeu::Interface) }

          it 'allows the use of top_left within border' do
            subject.border.to_s.must_equal(
              "\e(0{\e(B\e(0q\e(B\e(0k\e(B\n" \
              "\e(0x\e(B \e(0x\e(B\n" \
              "\e(0m\e(B\e(0q\e(B\e(0j\e(B"
            )
          end
        end
      end

      describe '#top_right' do
        let(:char) { 'B' }

        subject { instance.top_right(char) }

        it { subject.must_be_instance_of(String) }
        it { subject.must_equal('B') }

        context 'DSL #top_right' do
          subject {
            Vedeu.interface 'borders' do
              border do
                top_right '}'
              end
              geometry do
                height 3
                width  3
              end
              lines do
                line ''
              end
            end
          }

          it { subject.must_be_instance_of(Vedeu::Interface) }

          it 'allows the use of top_right within border' do
            subject.border.to_s.must_equal(
              "\e(0l\e(B\e(0q\e(B\e(0}\e(B\n" \
              "\e(0x\e(B \e(0x\e(B\n" \
              "\e(0m\e(B\e(0q\e(B\e(0j\e(B"
            )
          end
        end
      end

      describe '#vertical' do
        let(:char) { 'V' }

        subject { instance.vertical(char) }

        it { subject.must_be_instance_of(String) }
        it { subject.must_equal('V') }

        context 'DSL #vertical' do
          subject {
            Vedeu.interface 'borders' do
              border do
                vertical ':'
              end
              geometry do
                height 3
                width  3
              end
              lines do
                line ''
              end
            end
          }

          it { subject.must_be_instance_of(Vedeu::Interface) }

          it 'allows the use of vertical within border' do
            subject.border.to_s.must_equal(
              "\e(0l\e(B\e(0q\e(B\e(0k\e(B\n" \
              "\e(0:\e(B \e(0:\e(B\n" \
              "\e(0m\e(B\e(0q\e(B\e(0j\e(B"
            )
          end
        end
      end

    end # Border

  end # DSL

end # Vedeu
