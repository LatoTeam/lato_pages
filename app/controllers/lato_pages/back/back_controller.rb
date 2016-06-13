# Includo l'interfaccia di lato_core
include LatoCore::Interface
# Includo l'interfaccia di lato_view
include LatoView::Interface
# Includo l'interfaccia di lato_pages
include LatoPages::Interface

module LatoPages
  # Classe che gestisce il pannello di backoffice del modulo
  class Back::BackController < ApplicationController

    # Imposto layout di base dal lato_view
    layout 'lato_layout'

    # Attivo il controllo delle credenziali
    before_action :core_controlUser
  end
end
