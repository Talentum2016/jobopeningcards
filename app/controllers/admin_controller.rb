class AdminController < ApplicationController
  before_action :authenticate_user!
  before_action :load_options,
            only: [:new,:edit,:create,:update]
            
  def new
    @job_opening = JobOpening.new
  end
  
  def create
   @job_opening = JobOpening.create(job_opening_params)
   if @job_opening.valid?
      render :dashboard
    else
      render :new
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

  def destroy
    JobOpening.delete params[:id].to_i
    render :dashboard
  end

  private

  #Prepare params
  
  def job_opening_params
    res = params.require(:job_opening).permit(:id,:title,:description,:requirement,:image_job,
                                              :salary_min,:salary_max,:profession,:contract,:province)
    res[:user] = current_user
    res[:profession] = Profession.find res[:profession].to_i
    res
  end
  
# Prepare views

  def load_options
      @grouped_options = JobOpening.get_professions_grouped_for_select
      @contract_options = JobOpening.get_contracts_for_select
      @province_options = JobOpening.get_province_for_select
  end
end
