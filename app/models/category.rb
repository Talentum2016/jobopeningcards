class Category < ActiveRecord::Base

  has_many :professions, dependent: :destroy
end
