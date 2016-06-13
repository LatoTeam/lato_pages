module LatoPages
  # Classe che contiene tutti i moduli che generano l'interfaccia del modulo
  module Interface

    # Richiamo codice per accesso a funzioni di gestione lingue
    require 'lato_pages/interface/languages'
    include LatoPages::Interface::Languages
    # Richiamo dati per l'uso della cache del modulo
    require 'lato_pages/interface/config'
    include LatoPages::Interface::Config
    # Richiamo codice per accesso a funzioni di sviluppo front end applicazione
    require 'lato_pages/interface/template'
    include LatoPages::Interface::Template
    
  end
end
