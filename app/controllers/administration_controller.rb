class AdministrationController < ApplicationController
  def user
    authorize! :manage, User
    
    @users = User.all
  end
end
