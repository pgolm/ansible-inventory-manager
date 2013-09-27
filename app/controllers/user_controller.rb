class UserController < ApplicationController
  load_and_authorize_resource

  def show
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    if params[:user][:api_key]
      params[:user][:api_key] = User.generate_api_key
      flash[:notice] = 'New API Key was generated.'
    end

    if @user.update(user_params)
      redirect_to @user
    end
  end

  private

  def user_params
    params.require(:user).permit(:api_key) 
  end
end
