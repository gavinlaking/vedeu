require 'test_helper'

module Vedeu

  describe InternalAPI do

      it { Vedeu.must_respond_to(:background_colours) }
      it { Vedeu.must_respond_to(:borders) }
      it { Vedeu.must_respond_to(:buffers) }
      it { Vedeu.must_respond_to(:cursors) }
      it { Vedeu.must_respond_to(:debug) }
      it { Vedeu.must_respond_to(:documents) }
      it { Vedeu.must_respond_to(:events) }
      it { Vedeu.must_respond_to(:foreground_colours) }
      it { Vedeu.must_respond_to(:geometries) }
      it { Vedeu.must_respond_to(:groups) }
      it { Vedeu.must_respond_to(:interfaces) }
      it { Vedeu.must_respond_to(:keymaps) }
      it { Vedeu.must_respond_to(:menus) }
      it { Vedeu.must_respond_to(:ready!) }
      it { Vedeu.must_respond_to(:ready?) }
      it { Vedeu.must_respond_to(:renderer) }
      it { Vedeu.must_respond_to(:renderers) }
      it { Vedeu.must_respond_to(:resize) }
      it { Vedeu.must_respond_to(:timer) }

  end # InternalAPI

end # Vedeu
