class CardsController < ApplicationController
  before_action :authenticate_user!,
          except: [:index, :show]
  def index
  end

  def show
  end

  def panel
  end
end