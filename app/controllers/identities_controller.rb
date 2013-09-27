class IdentitiesController < ApplicationController
  load_and_authorize_resource

  def new
    @identity = env['omniauth.identity']
  end

  def update
    @identity = Identity.find(params[:id])

    if @identity.update(identity_params)
      flash[:notice] = 'Password changed.'
    end
    
    redirect_to root_path
  end

  private

  def identity_params
    params.require(:identity).permit(:password, :password_confirmation)
  end

end
