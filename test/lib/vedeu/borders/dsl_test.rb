require 'test_helper'

module Vedeu

  module Borders

    describe DSL do

      let(:described)  { Vedeu::Borders::DSL }
      let(:instance)   { described.new(model, client) }
      let(:model)      { Vedeu::Borders::Border.new(attributes) }
      let(:client)     {}
      let(:attributes) { { name: 'borders' } }
      let(:boolean)    { true }

      describe '.border' do
        let(:_name) { 'Vedeu::Borders::DSL' }

        after { Vedeu.borders.reset! }

        subject { described.border(_name) { } }

        it { subject.must_be_instance_of(Vedeu::Borders::Border) }

        context 'when the name is not given' do
          let(:_name) {}

          it { proc { subject}.must_raise(Vedeu::Error::MissingRequired) }
        end

        context 'when the block is not given' do
          subject { described.border(name) }

          it { proc { subject}.must_raise(Vedeu::Error::RequiresBlock) }
        end

      end

      describe '#bottom_left' do
        let(:char)    { 'C' }
        let(:options) { {} }

        subject { instance.bottom_left(char, options) }

        it { subject.must_be_instance_of(Vedeu::Cells::BottomLeft) }
      end
      describe '#bottom_left=' do
        it { instance.must_respond_to(:bottom_left=) }
      end

      describe '#bottom_right' do
        let(:char)    { 'D' }
        let(:options) { {} }

        subject { instance.bottom_right(char, options) }

        it { subject.must_be_instance_of(Vedeu::Cells::BottomRight) }
      end
      describe '#bottom_right=' do
        it { instance.must_respond_to(:bottom_right=) }
      end

      describe '#disable!' do
        subject { instance.disable! }

        it { instance.must_respond_to(:disabled!) }

        it { subject.must_be_instance_of(FalseClass) }
      end

      describe '#enable!' do
        subject { instance.enable! }

        it { instance.must_respond_to(:enabled!) }

        it { subject.must_be_instance_of(TrueClass) }
      end

      describe '#top_horizontal' do
        let(:char)    { 'T' }
        let(:options) { {} }

        subject { instance.top_horizontal(char, options) }

        it { subject.must_be_instance_of(Vedeu::Cells::TopHorizontal) }
      end

      describe '#top_horizontal=' do
        it { instance.must_respond_to(:top_horizontal=) }
      end

      describe '#bottom_horizontal' do
        let(:char)    { 'B' }
        let(:options) { {} }

        subject { instance.bottom_horizontal(char, options) }

        it { subject.must_be_instance_of(Vedeu::Cells::BottomHorizontal) }
      end

      describe '#bottom_horizontal=' do
        it { instance.must_respond_to(:bottom_horizontal=) }
      end

      describe '#horizontal' do
        let(:char)    { 'H' }
        let(:options) { {} }

        subject { instance.horizontal(char, options) }

        it { subject.must_be_instance_of(Vedeu::Cells::Horizontal) }
      end

      describe '#horizontal=' do
        it { instance.must_respond_to(:horizontal=) }
      end

      describe '#show_bottom' do
        subject { instance.show_bottom(boolean) }

        it { subject.must_be_instance_of(TrueClass) }

        context 'when false' do
          let(:boolean) { false }

          it { subject.must_be_instance_of(FalseClass) }
        end
      end

      describe '#bottom' do
        it { instance.must_respond_to(:bottom) }
      end

      describe '#bottom=' do
        it { instance.must_respond_to(:bottom=) }
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

        context 'when false' do
          let(:boolean) { false }

          it { subject.must_be_instance_of(FalseClass) }
        end
      end

      describe '#left' do
        it { instance.must_respond_to(:left) }
      end

      describe '#left=' do
        it { instance.must_respond_to(:left=) }
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

        context 'when false' do
          let(:boolean) { false }

          it { subject.must_be_instance_of(FalseClass) }
        end
      end

      describe '#right' do
        it { instance.must_respond_to(:right) }
      end

      describe '#right=' do
        it { instance.must_respond_to(:right=) }
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

        context 'when false' do
          let(:boolean) { false }

          it { subject.must_be_instance_of(FalseClass) }
        end
      end

      describe '#top' do
        it { instance.must_respond_to(:top) }
      end

      describe '#top=' do
        it { instance.must_respond_to(:top=) }
      end

      describe '#hide_top!' do
        subject { instance.hide_top! }

        it { subject.must_be_instance_of(FalseClass) }
      end

      describe '#show_top!' do
        subject { instance.show_top! }

        it { subject.must_be_instance_of(TrueClass) }
      end

      describe '#title' do
        let(:_value) { 'Some title'}

        subject { instance.title(_value) }

        it { subject.must_be_instance_of(String) }
        it { subject.must_equal('Some title') }
      end

      describe '#title=' do
        it { instance.must_respond_to(:title=) }
      end

      describe '#caption' do
        let(:_value) { 'Some caption'}

        subject { instance.caption(_value) }

        it { subject.must_be_instance_of(String) }
        it { subject.must_equal('Some caption') }
      end

      describe '#caption=' do
        it { instance.must_respond_to(:caption=) }
      end

      describe '#top_left' do
        let(:char)    { 'A' }
        let(:options) { {} }

        subject { instance.top_left(char, options) }

        it { subject.must_be_instance_of(Vedeu::Cells::TopLeft) }
      end

      describe '#top_left=' do
        it { instance.must_respond_to(:top_left=) }
      end

      describe '#top_right' do
        let(:char)    { 'B' }
        let(:options) { {} }

        subject { instance.top_right(char, options) }

        it { subject.must_be_instance_of(Vedeu::Cells::TopRight) }
      end

      describe '#top_right=' do
        it { instance.must_respond_to(:top_right=) }
      end

      describe '#use' do
        before do
          Vedeu.border 'some_border' do
            title 'Some border'
          end
          Vedeu.border 'other_border' do
            title use('some_border').title
          end
        end
        after { Vedeu.borders.reset }

        subject { instance.use('other_border').title }

        it 'allows the use of another models attributes' do
          subject
          Vedeu.borders.by_name('other_border').title.to_s.must_equal('Some border')
        end
      end

      describe '#left_vertical' do
        let(:char)    { 'V' }
        let(:options) { {} }

        subject { instance.left_vertical(char, options) }

        it { subject.must_be_instance_of(Vedeu::Cells::LeftVertical) }
      end

      describe '#left_vertical=' do
        it { instance.must_respond_to(:left_vertical=) }
      end

      describe '#right_vertical' do
        let(:char)    { 'V' }
        let(:options) { {} }

        subject { instance.right_vertical(char, options) }

        it { subject.must_be_instance_of(Vedeu::Cells::RightVertical) }
      end

      describe '#right_vertical=' do
        it { instance.must_respond_to(:right_vertical=) }
      end

      describe '#vertical' do
        let(:char)    { 'V' }
        let(:options) { {} }

        subject { instance.vertical(char, options) }

        it { subject.must_be_instance_of(Vedeu::Cells::Vertical) }
      end

      describe '#vertical=' do
        it { instance.must_respond_to(:vertical=) }
      end

    end # DSL

  end # Borders

end # Vedeu
