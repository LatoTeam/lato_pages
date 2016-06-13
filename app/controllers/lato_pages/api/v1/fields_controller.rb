module LatoPages
  # Api che gestisce l'invio del contenuto dei fields gestiti dal pannello
  class Api::V1::FieldsController < Api::V1::ApiController

    # Funzione per il recupero di tutti i campi. I campi possono essere
    # filtrati per pagina e lingua
    def index
      if params[:page] && params[:lang]
        page = LatoPages::Page.find_by(name: params[:page])
        render nothing: true, status: 404 and return false unless page
        @fields = LatoPages::Field.where(page_id: page.id,
                                         language: params[:lang]).select(:id,
                                                                         :name,
                                                                         :value,
                                                                         :typology,
                                                                         :page_id)
      elsif params[:page]
        page = LatoPages::Page.find_by(name: params[:page])
        render nothing: true, status: 404 and return false unless page
        @fields = LatoPages::Field.where(page_id: page.id).select(:id, :name,
                                                                  :value,
                                                                  :typology,
                                                                  :page_id)
      else
        @fields = LatoPages::Field.all.select(:id, :name, :value, :typology,
                                              :page_id)
      end

      render json: @fields
    end

    # Funzione per il recupero di un singolo field. Il campo puo' essere
    # filtrato per lingua.
    def show
      if params[:lang]
        page = LatoPages::Page.find_by(name: params[:page])
        render nothing: true, status: 404 and return false unless page
        @field = LatoPages::Field.select(:id, :name, :value, :typology,
                                         :page_id).find_by(name: params[:name],
                                                           page_id: page.id,
                                                           language: params[:lang])
      else
        page = LatoPages::Page.find_by(name: params[:page])
        render nothing: true, status: 404 and return false unless page
        @field = LatoPages::Field.select(:id, :name, :value, :typology,
                                         :page_id).find_by(name: params[:name],
                                                           page_id: page.id)
      end

      render json: @field
    end

  end
end
