class UsersController < ApplicationController
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params([:email]))

    if @user.save
      flash[:notice] = 'The User is successfully saved!'
      redirect_to user_show_map(@user)
    else
      flash[:error] = @user.errors.full_messages
      redirect_to signup_path
    end
  end
  
  def edit
    @user = User.find params[:id]
  end
  
  def update
    @user = User.find params[:id]

    if @user.update_attributes(user_params)
      flash[:notice] = 'The User is successfully updated!'
      redirect_to edit_user_path
    else
      flash[:error] = @user.errors.full_messages
      redirect_to edit_user_path
    end
  end
  
  def show_map
    @user = User.find params[:user_id]
    if @user
      @user[:longitude] = request.location.longitude  
      @user[:latitude] = request.location.latitude
      @user.save!
    else
      redirect_to signup_path
    end  
  end
  
  private
   
  def user_params(additional_permits = [])
    additional_permits << [:password, :password_confirmation, :full_name]
    params.require(:user).permit(additional_permits.flatten.map(&:to_sym))
  end
  
end