module Vedeu

  module Editor

    # Allows the storing of documents.
    #
    class Repository < Vedeu::Repositories::Repository

      singleton_class.send(:alias_method, :documents, :repository)

      real Vedeu::Editor::Document
      null Vedeu::Editor::Document

    end # Repository

  end # Editor

end # Vedeu
