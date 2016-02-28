class JobOpening < ActiveRecord::Base
  belongs_to :user
  belongs_to :profession
  has_attached_file :image_job,
                    path: ":rails_root/public/system/:attachment/:id/:basename_:style.:extension",
                    url: "/system/:attachment/:id/:basename_:style.:extension"
  validates_attachment :image_job,
                     content_type: { content_type: ["image/jpeg", "image/gif", "image/png"] }
  validates_attachment_size :image_job, less_than: 2.megabytes                   
  validates_presence_of :title, :description
end
