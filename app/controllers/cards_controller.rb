class CardsController < ApplicationController
  before_action :authenticate_user!,
          except: [:index, :show]
  def index
  end

  def show
  end

  def dashboard
    
  end
  
  def add 
    @grouped_options = []
    categories = Category.all 
    professions = Profession.all
     for category in categories
        auxCategory = [category.tittle]
       @grouped_options << auxCategory
         auxOptions = []
         auxCategory << auxOptions
        for profession in professions
          if category.id == profession.category.id
            auxOptions << [profession.tittle, profession.id]
          end
        end
     end
  end
  
  def create
    
  end
end