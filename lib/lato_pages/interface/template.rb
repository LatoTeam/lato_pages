module LatoPages
  module Interface
    # Funzioni usate per lo sviluppo dei template delle pagine gestite da
    # lato pages
    module Template
      
      # Funzione per ottenere il field di una pagina definita dai parametri
      # ricevuti
      # * *Params* :
      # - field: Nome univoco del field che si vuole prendere
      # - page: Nome univoco della pagina dalla quale si vogliono ottenere i
      # field
      # - lang: Lingua del contenuto da estrarre (nil se l'applicazione non ha
      # alcuna lingua impostata)
      def pages_getField(field, page, lang)
        page = LatoPages::Page.find_by(name: page)
        return false unless page
        field = LatoPages::Field.find_by(name: field, page_id: page.id,
                                         language: lang)
        field.value
      end

    end

  end
end
