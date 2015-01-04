require 'test_helper'

module Vedeu

  describe Refresh do

    let(:described) { Vedeu::Refresh }

    describe '.all' do
      subject { described.all }

      it { return_type_for(subject, Array) }

      context 'when there are no registered interfaces' do
        it { return_value_for(subject, []) }
      end

      # context 'when there are registered interfaces' do
      #   it { return_value_for(subject, ['hydrogen', 'helium']) }
      # end
    end

    # describe '.by_focus' do
    #   context 'when there are no registered interfaces' do
    #     it { proc { Refresh.by_focus }.must_raise(NoInterfacesDefined) }
    #   end

    #   context 'when there are registered interfaces' do
    #   end
    # end

    # describe '.by_group' do
    #   context 'when there are no registered groups' do
    #     before { Vedeu.groups_repository.reset }

    #     it { proc { Refresh.by_group('') }.must_raise(ModelNotFound) }
    #   end

    #   context 'when there are registered groups' do
    #   end
    # end

    # describe '.by_name' do
    #   let(:interface_name) { 'aluminium' }

    #   subject { Refresh.by_name(interface_name) }

    #   context 'when the interface or buffer is not found' do
    #     let(:interface_name) { '' }

    #     it { proc { Refresh.by_name('') }.must_raise(ModelNotFound) }
    #   end

    #   context 'when the interface or buffer is found' do
    #     # it { return_type_for(subject, Array) }

    #     it { skip }
    #   end
    # end

  end # Refresh

end # Vedeu
