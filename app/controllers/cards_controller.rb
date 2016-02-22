class CardsController < ApplicationController
  before_action :authenticate_user!,
          except: [:index, :show, :search]
  def index
    @jobopenings=Jobopening.all
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
    
    for jobopening in jobopenings
        if jobopening.tittle.downcase.include? text.downcase
          @jobopenings << jobopening
        end
    end
    render :index
  end
end
