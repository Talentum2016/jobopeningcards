class Profession < ActiveRecord::Base

has_many :jobopening, :dependent => :nullify
belongs_to :category
end
