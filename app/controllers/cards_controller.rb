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
    @grouped_options = get_professions_grouped
  end
  
  def create
    title = params[:title]
    description  = params[:description]
    # image = params[:image]
    requirement = params[:requirement]
    salary_min = params[:salary_min]
    salary_max = params[:salary_max]
    profession = params[:profession]
    # province = params[:province]

    createHash = {}
    createHash[:user_id] = current_user.id
    createHash[:title] = title
    createHash[:description]  = description
    # createHash[:image] = image
    createHash[:requirement] = requirement
    createHash[:salary_min] = salary_min
    createHash[:salary_max] = salary_max
    createHash[:profession] = Profession.find profession.to_i
    # createHash[:province] = province
    
   job_opening=JobOpening.create(createHash)
    
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
    id=params[:id]
    @job_opening=JobOpening.find id   
  end
  
  def update_job_opening
    id=params[:id]
    job_opening=JobOpening.find id.to_i 
    job_opening.title=params[:title]
    job_opening.description=params[:description]
    #job_opening.image=params[:image]
    job_opening.requirement=params[:requirement]
    job_opening.salary_min=params[:salary_min]
    job_opening.salary_max=params[:salary_max]
    #job_opening.province=params[:province]
    job_opening.profession=Profession.find params[:profession].to_i
    job_opening.save
    render :dashboard
  end

  def user_options
    @user=User.find current_user.id      
  end
  
  def update_photo
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
  
  def user_params
    params.require(:user).permit(:image)
    
  end
  
end

