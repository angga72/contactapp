class NoContact < ApplicationRecord
  belongs_to :contact
  enum no_type: %i[Handphone Home Office ]
end
