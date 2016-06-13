# Includo l'interfaccia di lato_core
include LatoCore::Interface

module LatoPages
  module Interface
    # Funzioni usate per la gestione dei dati di pages rispetto alle lingue
    # dell'applicazione
    module Languages

      # Funzione che legge le lingue dell'applicazione, confronta i dati nel
      # database e fa in modo che i campi siano conformi alle lingue.
      def pages_syncConfigLanguages
        fields = LatoPages::Field.all
        # gestisco il caso in cui sono passato da 0 lingue a n lingue
        if core_getApplicationLanguages && fields.first && fields.first.language.nil?
          fields.each do |field|
            core_getApplicationLanguages.each do |language|
              new_field = field.dup
              new_field.update(language: language)
            end
            field.destroy
          end
        end
        # gestisco il caso in cui passo da n lingue a 0 lingue
        if !core_getApplicationLanguages && fields.first && !fields.first.language.nil?
          existing_language = fields.first.language
          fields.each do |field|
            if field.language === existing_language
              field.update(language: nil)
            else
              field.destroy
            end
          end
        end
        # gestisco i casi in cui passo da n lingue a n+-1
        if core_getApplicationLanguages && fields.first && !fields.first.language.nil?
          # gestisco il caso in cui sono passato da n lingue a n+1
          core_getApplicationLanguages.each do |language|
            next unless fields.first &&
                        fields.where(language: language).length === 0
            existing_language = fields.first.language
            fields.where(language: existing_language).each do |field|
              new_field = field.dup
              new_field.update(language: language)
            end
          end
          # gestisco il caso in cui sono passato da n lingue a n-1
          fields.each do |field|
            if core_getApplicationLanguages && field.language &&
               !(core_getApplicationLanguages.include? field.language)
              field.destroy
            end
          end
        end
      end

    end

  end
end
