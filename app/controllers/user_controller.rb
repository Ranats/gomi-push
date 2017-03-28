class UserController < ApplicationController

  def create
    @gomi = Gomi.new
    @gomi.name = params[:gomi][:name]
    @gomi.every = params[:gomi][:every]
    @gomi.save
    redirect_to '/gomi/show'
  end

end
