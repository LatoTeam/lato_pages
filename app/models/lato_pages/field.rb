module LatoPages
  # Modello dei campi delle pagine
  class Field < ActiveRecord::Base
    # Validazione attributi
    validates :name, presence: true,
                     length: { maximum: 50 }

    validates :title, presence: true

    validates :typology, presence: true

    validates :page_id, presence: true

    validates_uniqueness_of :name, scope: [:page_id, :language]

    # Azioni prima del salvataggio
    before_save do
      self.name = name.downcase
    end

    # Relazioni
    belongs_to :page
  end
end
