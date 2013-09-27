class IdentitiesController < ApplicationController
  load_and_authorize_resource

  def new
    @identity = env['omniauth.identity']
  end
end
