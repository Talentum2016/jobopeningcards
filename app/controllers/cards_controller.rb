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
  
   def update_data
    @user=User.find current_user.id
    @user.email=params[:email]
    @user.company=params[:company]
    @user.cif=params[:cif]
    @user.save
    if @user.errors.any? then
      puts "email vacio"
    end
    render :user_options
    
    
  end

  private
  
  def get_professions_grouped
    grouped_options = []
    categories = Category.all 
    professions = Profession.all
    for category in categories
       auxCategory = [category.title.strip]
       grouped_options << auxCategory
       auxOptions = []
       auxCategory << auxOptions
       professions=category.professions.sort_by{|m|m.title.downcase}
       for profession in professions
         auxOptions << [profession.title.strip, profession.id]
       end
    end
    grouped_options.sort_by{|m|m.first.downcase}
  end
  
  def get_category_for_select
    search_options=[]
    categories=Category.all
    for category in categories
      search_options << [category.title.strip,category.id] 
    end
    search_options.sort_by{|m|m.first.downcase}
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

