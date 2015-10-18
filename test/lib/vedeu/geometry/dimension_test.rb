require 'test_helper'

module Vedeu

  module Geometry

    describe Dimension do

      let(:described)  { Vedeu::Geometry::Dimension }
      let(:instance)   { described.new(attributes) }
      let(:attributes) {
        {
          d:         d,
          dn:        dn,
          d_dn:      d_dn,
          default:   default,
          maximised: maximised,
          centred:   centred,
          alignment: alignment,
        }
      }
      let(:d)         {}
      let(:dn)        {}
      let(:d_dn)      {}
      let(:default)   {}
      let(:maximised) {}
      let(:centred)   {}
      let(:alignment) {}

      describe '#initialize' do
        it { instance.must_be_instance_of(described) }
        it { instance.instance_variable_get('@d').must_equal(d) }
        it { instance.instance_variable_get('@dn').must_equal(dn) }
        it { instance.instance_variable_get('@d_dn').must_equal(d_dn) }
        it { instance.instance_variable_get('@default').must_equal(default) }
        it { instance.instance_variable_get('@maximised').must_equal(maximised) }
        it { instance.instance_variable_get('@centred').must_equal(centred) }
        it { instance.instance_variable_get('@alignment').must_equal(alignment) }
      end

      describe '.pair' do
        let(:d)  { 15 }
        let(:dn) { 38 }

        subject { described.pair(attributes) }

        it { subject.must_be_instance_of(Array) }
        it { subject.must_equal([15, 38]) }

        context 'when maximised' do
          let(:maximised) { true }
          let(:default)   { 80 }

          it { subject.must_equal([1, 80]) }
        end

        context 'when left aligned' do
          let(:alignment) { :left }
          let(:default)   { 80 }

          context 'when a width (d_dn) is set' do
            let(:d_dn) { 20 }

            it { subject.must_equal([1, 20]) }

            context 'when the width is greater than the terminal width' do
              let(:d_dn) { 100 }

              it { subject.must_equal([1, 80]) }
            end
          end

          context 'when a dn is set' do
            it { subject.must_equal([1, 38]) }
          end

          context 'when neither width nor dn is set' do
            let(:dn) {}

            it { subject.must_equal([1, 80]) }
          end
        end

        context 'when right aligned' do
          let(:alignment) { :right }
          let(:default)   { 80 }

          context 'when a width (d_dn) is set' do
            let(:d_dn) { 20 }

            it { subject.must_equal([60, 80]) }

            context 'when the width is greater than the terminal width' do
              let(:d_dn) { 100 }

              it { subject.must_equal([1, 80]) }
            end
          end

          context 'when a d is set' do
            let(:d) { 58 }

            it { subject.must_equal([58, 80]) }
          end

          context 'when neither width nor d is set' do
            let(:d) {}

            it { subject.must_equal([1, 80]) }
          end
        end

        context 'when centre aligned' do
          let(:alignment) { :centre }
          let(:default) { 80 }

          context 'when d and dn are given' do
            let(:d)  { 7 }
            let(:dn) { 47 }

            it { subject.must_equal([20, 60]) }
          end

          context 'when only a d_dn is given' do
            let(:d_dn) { 30 }

            it { subject.must_equal([28, 52]) }
          end

          context 'when only a default is given' do
            it { subject.must_equal([28, 52]) }
          end
        end
      end

      describe '#d1' do
        subject { instance.d1 }

        it { subject.must_be_instance_of(Fixnum) }

        # context 'when not centred and/or a length cannot be determined' do
        #   context 'when d is given' do
        #     let(:d) { 5 }

        #     it { subject.must_equal(5) }
        #   end

        #   context 'when d is not given' do
        #     it { subject.must_equal(1) }
        #   end
        # end

        # context 'when centred and a length can be determined' do
        #   let(:centred) { true }
        #   let(:default) { 80 }

        #   context 'when d and dn are given' do
        #     let(:d)  { 7 }
        #     let(:dn) { 47 }

        #     it { subject.must_equal(20) }
        #   end

        #   context 'when only a d_dn is given' do
        #     let(:d_dn) { 30 }

        #     it { subject.must_equal(25) }
        #   end

        #   context 'when only a default is given' do
        #     it { subject.must_equal(1) }
        #   end
        # end
      end

      describe '#d2' do
        subject { instance.d2 }

        it { subject.must_be_instance_of(Fixnum) }

        # context 'when not centred and/or a length cannot be determined' do
        #   context 'when d and dn are given' do
        #     let(:d)  { 5 }
        #     let(:dn) { 8 }

        #     it { subject.must_equal(8) }
        #   end

        #   context 'when d and d_dn are given' do
        #     let(:d)    { 5 }
        #     let(:d_dn) { 2 }

        #     it { subject.must_equal(6) }
        #   end

        #   context 'when only d_dn is given' do
        #     let(:d_dn) { 6 }

        #     it { subject.must_equal(6) }
        #   end

        #   context 'when only dn is given' do
        #     let(:dn) { 8 }

        #     it { subject.must_equal(8) }
        #   end

        #   context 'when d and a default is given' do
        #     let(:d)       { 1 }
        #     let(:default) { 40 }

        #     it { subject.must_equal(40) }
        #   end

        #   context 'when only a default is given' do
        #     let(:default) { 25 }

        #     it { subject.must_equal(25) }
        #   end

        #   context 'when no default is given' do
        #     it { subject.must_equal(nil) }
        #   end
        # end

        # context 'when centred and a length can be determined' do
        #   let(:centred) { true }
        #   let(:default) { 80 }

        #   context 'when d and dn are given' do
        #     let(:d)  { 7 }
        #     let(:dn) { 47 }

        #     it { subject.must_equal(60) }
        #   end

        #   context 'when only a d_dn is given' do
        #     let(:d_dn) { 30 }

        #     it { subject.must_equal(55) }
        #   end

        #   context 'when only a default is given' do
        #     it { subject.must_equal(80) }
        #   end
        # end
      end

    end # Dimension

  end # Geometry

end # Vedeu
