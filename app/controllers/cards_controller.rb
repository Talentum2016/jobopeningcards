class CardsController < ApplicationController
  before_action :authenticate_user!,
          except: [:index, :show, :search, :more]
  before_action :load_options,
            only: [:add,:edit,:create,:update_job_opening]

#Public    
  def index
    @jobs_limit = 10
    load_index_options
  end
  
  def more
    @jobs_limit = params[:limit].to_i + 10
    load_index_options
    render :index
  end

  def show
    @job_opening = JobOpening.find params[:id] 
  end
  
  def search
    @search_options = get_category_for_select
    @job_openings = JobOpening.joins("JOIN professions ON professions.id = job_openings.profession_id ")
                              .where("job_openings.title LIKE ? AND (category_id = ? OR ?='')", "%#{params[:search_text]}%","#{params[:search_category]}","#{params[:search_category]}")
    render :index
  end
 
#For logged users 
 
  def delete
    JobOpening.delete params[:id].to_i
    #@job_openings = JobOpening.where("user_id = ?", current_user.id)
    render :dashboard
  end
  
  def add
    @job_opening = JobOpening.new
  end
  
  def create
   @job_opening = JobOpening.create(job_opening_params)
   if @job_opening.valid?
      #@job_openings = JobOpening.where("user_id = ?", current_user.id)
      render :dashboard
    else
      render :add
    end
  end
  
  def edit
    @job_opening=JobOpening.find params[:id]
  end
  
  def update
    update_data = job_opening_params
    @job_opening=JobOpening.find update_data[:id]
    if @job_opening.update(update_data)
      render :dashboard
    else
      render :edit
    end
  end

  def user_options
    @user=User.find current_user.id      
  end
  
  def update_user
    @user=User.find current_user.id
    @user.update(user_params)
    render :user_options
  end

  private
  
  #Prepare selects
  
  def get_professions_grouped_for_select
    Category.order(:title).map {
      |category| [category.title.strip, 
        category.professions.order(:title).map {
          |profession| [profession.title.strip,profession.id]}]} 
  end
  
  def get_category_for_select
    Category.order(:title).map{|category| [category.title.strip,category.id]}
            .unshift(['-- selecciona una categoría --',disabled: true, selected: true] )
  end
  
  def get_contracts_for_select
    ["No especificado","Indefinido","Temporal","Autónomo/freelance","Tiempo parcial","Beca/Prácticas"]
  end
  
  def get_province_for_select
    ['Alava','Albacete','Alicante','Almería','Asturias','Avila','Badajoz','Barcelona','Burgos','Cáceres',
    'Cádiz','Cantabria','Castellón','Ciudad Real','Córdoba','La Coruña','Cuenca','Gerona','Granada','Guadalajara',
    'Guipúzcoa','Huelva','Huesca','Islas Baleares','Jaén','León','Lérida','Lugo','Madrid','Málaga','Murcia','Navarra',
    'Orense','Palencia','Las Palmas','Pontevedra','La Rioja','Salamanca','Segovia','Sevilla','Soria','Tarragona',
    'Santa Cruz de Tenerife','Teruel','Toledo','Valencia','Valladolid','Vizcaya','Zamora','Zaragoza']
  end
  
  #Prepare params
  
  def job_opening_params
    res = params.require(:job_opening).permit(:id,:title,:description,:requirement,:image_job,
                                              :salary_min,:salary_max,:profession,:contract,:province)
    res[:user] = current_user
    res[:profession] = Profession.find res[:profession].to_i
    res
  end
  
  def user_params
    params.require(:user).permit(:email,:company,:cif,:image)
  end
  
end

# Prepare views

def load_options
    @grouped_options = get_professions_grouped_for_select
    @contract_options = get_contracts_for_select
    @province_options = get_province_for_select
end

def load_index_options
    @job_openings = JobOpening.order("created_at DESC LIMIT #{@jobs_limit}")
    @search_options = get_category_for_select
end