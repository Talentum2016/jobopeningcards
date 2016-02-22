class CardsController < ApplicationController
  before_action :authenticate_user!,
          except: [:index, :show, :search]
  def index
    @jobopenings=Jobopening.all
    @search_options=[]
    categories=Category.all
    for category in categories
      @search_options << [category.tittle,category.id]
    end
    
  end

  def show
  end

  def panel
  end
  
  def add
    
  end
  def search
    jobopenings=Jobopening.all
    @jobopenings=[]
    text=params[:search_value]
    category=params[:search_category]
    for jobopening in jobopenings
        if jobopening.tittle.downcase.include? text.downcase
          #if jobopening.category.id==category
            @jobopenings << jobopening
          #end
        end
    end
    render :index
  end
  
end
