class UserController < ApplicationController
  load_and_authorize_resource

  def show
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    if params[:user][:api_key]
      params[:user][:api_key] = User::next_secure_key
      flash[:notice] = 'New API Key was generated.'
    end

    if @user.update(user_params)
      redirect_to @user
    end
  end

  def destroy
    begin
      User.find(params[:id]).destroy
      flash[:notice] = "User was deleted."
    rescue
      flash[:alert] = "User couldn't be deleted."
    end

    redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit(:api_key) 
  end
end
