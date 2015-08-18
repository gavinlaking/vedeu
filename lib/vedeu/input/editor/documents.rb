module Vedeu

  module Editor

    # Allows the storing of documents.
    #
    class Documents < Vedeu::Repository

      singleton_class.send(:alias_method, :documents, :repository)

      real Vedeu::Editor::Document
      null Vedeu::Editor::Document

    end # Documents

  end # Editor

end # Vedeu
