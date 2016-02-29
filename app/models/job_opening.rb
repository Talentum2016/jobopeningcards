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
  
  
  def self.get_professions_grouped_for_select
    Category.order(:title).map {
      |category| [category.title.strip, 
        category.professions.order(:title).map {
          |profession| [profession.title.strip,profession.id]}]} 
  end

  def self.get_contracts_for_select
    ["No especificado","Indefinido","Temporal","Autónomo/freelance","Tiempo parcial","Beca/Prácticas"]
  end
  
  def self.get_province_for_select
    ['Alava','Albacete','Alicante','Almería','Asturias','Avila','Badajoz','Barcelona','Burgos','Cáceres',
    'Cádiz','Cantabria','Castellón','Ciudad Real','Córdoba','La Coruña','Cuenca','Gerona','Granada','Guadalajara',
    'Guipúzcoa','Huelva','Huesca','Islas Baleares','Jaén','León','Lérida','Lugo','Madrid','Málaga','Murcia','Navarra',
    'Orense','Palencia','Las Palmas','Pontevedra','La Rioja','Salamanca','Segovia','Sevilla','Soria','Tarragona',
    'Santa Cruz de Tenerife','Teruel','Toledo','Valencia','Valladolid','Vizcaya','Zamora','Zaragoza']
  end
  
end
