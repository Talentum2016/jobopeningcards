class CardsController < ApplicationController
  before_action :authenticate_user!,
          except: [:index, :show, :search]
  
  def index
    @jobopenings=Jobopening.all
    @search_options=get_category_for_select
  end

  def show
    id=params[:id]
    @jobopening=Jobopening.find id   
  end
 
  def delete
    id = params[:id].to_i
    Jobopening.delete id
    @jobopenings = Jobopening.all
    render :dashboard
  end
  
  def add 
    @grouped_options = get_professions_grouped
  end
  
  def create
    tittle = params[:tittle]
    description  = params[:description]
    # image = params[:image]
    requirement = params[:requirement]
    salary_min = params[:salary_min]
    salary_max = params[:salary_max]
    profession = params[:profession]
    # province = params[:province]

    createHash = {}
    createHash[:user_id] = current_user.id
    createHash[:tittle] = tittle
    createHash[:description]  = description
    # createHash[:image] = image
    createHash[:requirement] = requirement
    createHash[:salary_min] = salary_min
    createHash[:salary_max] = salary_max
    createHash[:profession] = Profession.find profession.to_i
    # createHash[:province] = province
    
   jobopening=Jobopening.create(createHash)
    
   @jobopenings=Jobopening.all
   
   render "dashboard" 
  end

  def search
    jobopenings=Jobopening.all
    @jobopenings=[]
    @search_options=get_category_for_select
    text=params[:search_value]
    category=params[:search_category]
    for jobopening in jobopenings
        if jobopening.tittle.downcase.include? text.downcase
          if jobopening.profession.category.id==category.to_i || category == nil
            @jobopenings << jobopening
          end
        end
    end
    render :index
  end
  
  def edit
    @grouped_options = get_professions_grouped
    id=params[:id]
    @jobopening=Jobopening.find id   
  end
  
  def update_jobopening
    id=params[:id]
    jobopening=Jobopening.find id.to_i 
    jobopening.tittle=params[:tittle]
    jobopening.description=params[:description]
    #jobopening.image=params[:image]
    jobopening.requirement=params[:requirement]
    jobopening.salary_min=params[:salary_min]
    jobopening.salary_max=params[:salary_max]
    #jobopening.province=params[:province]
    jobopening.profession=Profession.find params[:profession].to_i
    jobopening.save
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
       auxCategory = [category.tittle.strip]
       grouped_options << auxCategory
       auxOptions = []
       auxCategory << auxOptions
       professions=category.profession.sort_by{|m|m.tittle.downcase}
       for profession in professions
         auxOptions << [profession.tittle.strip, profession.id]
       end
    end
    grouped_options.sort_by{|m|m.first.downcase}
  end
  
  def get_category_for_select
    search_options=[]
    categories=Category.all
    for category in categories
      search_options << [category.tittle.strip,category.id] 
    end
    search_options.sort_by{|m|m.first.downcase}
  end
  
  def user_params
    params.require(:user).permit(:image)
    
  end
  
end

