class Section < ApplicationRecord
    belongs_to :dataset
   has_many :pages
end
