class Contact < ApplicationRecord
has_many :no_contacts, dependent: :destroy
end
