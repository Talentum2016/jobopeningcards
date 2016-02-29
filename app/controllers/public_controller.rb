class PublicController < ApplicationController
  def index
    @jobs_limit = 10
    load_index_options
  end

  def show
    @job_opening = JobOpening.find params[:id] 
  end
  
  def search
    @jobs_limit = 30
    @search_options = get_category_for_select
    @job_openings = JobOpening.joins("JOIN professions ON professions.id = job_openings.profession_id ")
                              .where("job_openings.title LIKE ? AND (category_id = ? OR ?='') ", "%#{params[:search_text]}%","#{params[:search_category]}","#{params[:search_category]}")
                              .order("created_at DESC LIMIT #{@jobs_limit}")
    render :index
  end
  
  def more
    @jobs_limit = params[:limit].to_i + 10
    load_index_options
    render :index    
  end
  
  private
  
  def load_index_options
    @job_openings = JobOpening.order("created_at DESC LIMIT #{@jobs_limit}")
    @search_options = get_category_for_select
  end
  
  def get_category_for_select
    Category.order(:title).map{|category| [category.title.strip,category.id]}
            .unshift(['-- selecciona una categoría --',disabled: true, selected: true] )
  end
  
end
