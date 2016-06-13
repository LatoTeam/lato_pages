# Includo l'interfaccia di lato_core
include LatoCore::Interface

module LatoPages
  module Interface
    # Funzioni usate per la gestione dei dati di pages sul file di
    # configurazione
    module Config

      # Funzione che legge il file di configurazione salvato in cache e
      # utilizza i dati contenuti per configurare in modo corretto il database
      def pages_syncConfigFile
        # sincronizzo le pagine
        syncConfigPages
        # sincronizzo i campi
        syncConfigFields
      end


      # Funzione che sincronizza le pagine descritte nel file di
      # configurazione dell'applicazione con quelle memorizzate nel database
      private def syncConfigPages
        # controllo l'esistenza del file di configurazione
        directory = core_getCacheDirectory
        return false unless File.exist? "#{directory}/pages.yml"
        # estraggo i dati dal file di configurazione
        pages_yaml = extractDataFromConfig('pages', directory)
        # inizializzo array con i nomi delle pagine dello yaml
        pages_yaml_names = []
        # estraggo i dati dal database
        pages_db = LatoPages::Page.all
        # aggiungo le nuove pagine del file yaml nel database o se esistono gia'
        # le aggiorno
        pages_yaml.each do |page_yaml|
          data = page_yaml[1]
          # se la pagina esiste gia' nel database allora la aggiorno
          if page_db = pages_db.find_by(name: data['name'])
            page_db.update(title: data['title'], position: data['position'],
                           superpage_name: data['superpage'])
          # se la pagina non esiste nel database allora ne creo una per lingua
          else
            LatoPages::Page.create(name: data['name'], title: data['title'],
                                   position: data['position'],
                                   superpage_name: data['superpage'],
                                   last_edit: Time.now)
          end
          # riempio array con i nomi delle pagine dello yaml
          pages_yaml_names.push(data['name'])
        end
        # elimino le pagine del db che sono state eliminate dal file yaml
        pages_db.each do |page_db|
          # se la pagina nel database non esiste nello yaml allora la elimino
          unless pages_yaml_names.include? page_db.name
            page_db.destroy
          end
        end
      end


      # Funzione che sincronizza i campi descritti nel file di configurazione
      # dell'applicazione con quelli memorizzati nel database
      private def syncConfigFields
        # controllo l'esistenza del file di configurazione
        directory = core_getCacheDirectory()
        return false unless File.exist? "#{directory}/pages.yml"
        # estraggo i dati dal file di configurazione
        fields_yaml = extractDataFromConfig('fields', directory)
        # inizializzo array con i nomi dei campi dello yaml
        fields_yaml_names = []
        # estraggo i dati dal database
        fields_db = LatoPages::Field.all
        pages_db = LatoPages::Page.all
        # aggiungo i nuovi campi del file yaml nel database o se esistono
        # gia' gli aggiorno
        fields_yaml.each do |field_yaml|
          data = field_yaml[1]
          # verifico che il campo sia collegato ad una pagina esistente
          if current_page = pages_db.find_by(name: data['page'])
            # se i field esistono gia' allora vado a modificarli con i nuovi
            # dati
            current_fields_db = fields_db.where(name: data['name'],
                                                page_id: current_page.id)
            if current_fields_db && current_fields_db.length > 0
              current_fields_db.each do |current_field_db|
                current_field_db.update(title: data['title'],
                                        typology: data['typology'],
                                        position: data['position'],
                                        width: data['width'],
                                        metadata: data['metadata'])
              end
            # se i field non esistono allora ne creo uno per lingua
            elsif core_getApplicationLanguages
              core_getApplicationLanguages.each do |language|
                LatoPages::Field.create(name: data['name'],
                                        title: data['title'],
                                        typology: data['typology'],
                                        position: data['position'],
                                        width: data['width'],
                                        metadata: data['metadata'],
                                        page_id: current_page.id,
                                        language: language)
              end
            else
              LatoPages::Field.create(name: data['name'],
                                      title: data['title'],
                                      typology: data['typology'],
                                      position: data['position'],
                                      width: data['width'],
                                      metadata: data['metadata'],
                                      page_id: current_page.id)
            end
            # riempio array con i nomi dei campi dello yaml
            fields_yaml_names.push([data['name'], current_page.id])
          end
        end
        # elimino i campo del db che sono stati eliminati dal file yaml
        fields_db.each do |field_db|
          # se la pagina nel database non esiste nello yaml allora la elimino
          unless fields_yaml_names.include? [field_db.name, field_db.page_id]
            field_db.destroy
          end
        end
      end

      # Funzione che estrae i dati dal file di configurazione.
      # Il parametro richiesto e' il tipo di dato da estrarre dallo yaml
      # ('pages' o 'fields')
      private def extractDataFromConfig(data, directory)
        file = YAML::load(File.open("#{directory}/pages.yml"))
        file[data]
      end

    end

  end
end
