class CardsController < ApplicationController
  before_action :authenticate_user!,
          except: [:index, :show, :search]
  
  def index
    @job_openings=JobOpening.all
    @search_options=get_category_for_select
  end

  def show
    id=params[:id]
    @job_opening=JobOpening.find id   
  end
 
  def delete
    id = params[:id].to_i
    JobOpening.delete id
    @job_openings = JobOpening.all
    render :dashboard
  end
  
  def add
    @job_opening = JobOpening.new
    @grouped_options = get_professions_grouped
  end
  
  def create
   @job_opening = JobOpening.create(job_opening_params)
   @job_openings=JobOpening.all
   
   render "dashboard" 
  end

  def search
    job_openings=JobOpening.all
    @job_openings=[]
    @search_options=get_category_for_select
    text=params[:search_value]
    category=params[:search_category]
    for job_opening in job_openings
        if job_opening.title.downcase.include? text.downcase
          if job_opening.profession.category.id==category.to_i || category == nil
            @job_openings << job_opening
          end
        end
    end
    render :index
  end
  
  def edit
    @grouped_options = get_professions_grouped
    @job_opening=JobOpening.find params[:id]  
  end
  
  def update_job_opening
    update_data = job_opening_params
    @job_opening=JobOpening.find update_data[:id]
    @job_opening.update(update_data)
    
    render :dashboard
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
  
  def get_professions_grouped
    @grouped_options = Category.order(:title).map {
                            |category| [category.title.strip, 
                              category.professions.order(:title).map {
                                |profession| [profession.title.strip,profession.id]}]} 
  end
  
  def get_category_for_select
    Category.order(:title).map{|category| [category.title.strip,category.id]}
            .unshift(['-- selecciona una opción --',disabled: true, selected: true] )
  end
  
  def job_opening_params
    res = params.require(:job_opening).permit(:id,:title,:description,:requirement,
                                              :salary_min,:salary_max,:profession)
    res[:user] = current_user
    res[:profession] = Profession.find res[:profession].to_i
    res
  end
  
  def user_params
    params.require(:user).permit(:email,:company,:cif,:image)
  end
  
end

