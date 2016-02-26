class Profession < ActiveRecord::Base

has_many :job_openings, :dependent => :nullify
belongs_to :category
end
