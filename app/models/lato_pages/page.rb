module LatoPages
  # Modello delle pagine
  class Page < ActiveRecord::Base
    # Validazione attributi
    validates :name, presence: true,
                     length: { maximum: 50 }

    validates :title, presence: true

    validates_uniqueness_of :name

    # Azioni prima del salvataggio
    before_save do
      self.name = name.downcase
    end

    # Relazioni
    has_many :fields, dependent: :destroy

    # Nome completo della pagina
    def complete_title
      return "#{self.superpage.complete_title} - #{self.title}" if self.superpage
      self.title
    end

    # Pagina genitore
    def superpage
      LatoPages::Page.find_by(name: self.superpage_name)
    end

    # Giorno dell'ultima modifica (stringa)
    def edit_day
      self.last_edit.strftime('%d/%m/%Y')
    end

    # Ora dell'ultima modifica (stringa)
    def edit_hour
      self.last_edit.strftime('%H:%M')
    end

    # Giorno e ora dell'ultima modifica (stringa)
    def edit_time
      "#{self.edit_day} - #{self.edit_hour}"
    end
  end
end
