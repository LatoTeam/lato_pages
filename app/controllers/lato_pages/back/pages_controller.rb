module LatoPages
  # Classe che gestisce il pannello di backoffice del modulo
  class Back::PagesController < Back::BackController

    before_action :control_permission
    before_action :set_unique_name

    def index
      @pages = LatoPages::Page.where(visible: true)
    end

    def edit
      @page = LatoPages::Page.find(params[:id])
      @fields = @page.fields.where(visible: true).order('position ASC')
    end

    def update
      page = LatoPages::Page.find(params[:id])

      params[:fields].each do |field|
        update_field = LatoPages::Field.find(field[0].to_i)
        if !update_field || !update_field.update(value: field[1])
          flash[:danger] = PAGES_LANG['pages']['failed_update']
          redirect_to lato_pages.page_path(page.id) and return false
        end
      end

      # aggiorno il timestamp di modifica della pagina
      page.update(last_edit: Time.now)

      flash[:success] = PAGES_LANG['pages']['success_update']
      redirect_to lato_pages.edit_page_path(page.id)
    end


    # Lista funzioni chiamate da resources dei routes riempite momentaneamente
    # con un redirect
    def new
      redirect_to lato_pages.pages_path
    end

    def create
      redirect_to lato_pages.pages_path
    end

    def show
      redirect_to lato_pages.page_path(params[:id])
    end

    def destroy
      redirect_to lato_pages.page_path(params[:id])
    end

    # Imposta la voce della navbar degli utenti come attiva
    private def set_unique_name
      view_setCurrentVoice('pages_pages')
    end

    # Controlla che l'utente abbia i permessi per eseguire le azioni di
    # gestione pagine
    private def control_permission
      unless core_controlPermission(6)
        flash[:warning] = PAGES_LANG['pages']['failed_permission']
        redirect_to lato_pages.pages_path and return false
      end
    end

  end
end
