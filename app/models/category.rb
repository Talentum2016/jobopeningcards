class Category < ActiveRecord::Base

has_many :profession, :dependent => :destroy
end
