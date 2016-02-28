class Profession < ActiveRecord::Base

has_many :job_openings, :dependent => :nullify
belongs_to :category
  has_attached_file :image_prof,
                    :path => ":rails_root/public/system/:attachment/:id/:basename_:style.:extension",
                    :url => "/system/:attachment/:id/:basename_:style.:extension"
  validates_attachment :image_prof,
                     content_type: { content_type: ["image/jpeg", "image/gif", "image/png"] }
end
