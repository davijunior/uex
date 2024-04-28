class Contact < ApplicationRecord
    has_one :address
    validates :cpf, uniqueness: true, presence: true
    validates :name, :phone, presence: true

    default_scope { includes(:address).order(name: :asc) }

    def self.find_by_cpf(cpf)
        where(cpf: cpf)
    end
end
