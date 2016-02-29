class UsersController < ApplicationController
  before_action :authenticate_user!
 
  def user_options
    @user = User.find current_user.id      
  end
  
  def update_user
    @user = User.find current_user.id
    @user.update(user_params)
    render :user_options
  end
  
  private
  
  def user_params
    params.require(:user).permit(:email,:company,:cif,:image)
  end

end
