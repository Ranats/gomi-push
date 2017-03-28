class GomiController < ApplicationController

  def gomi_params
    params.require(:gomi).permit(
        gomis_attributes: [:id, :_destroy]
    )
  end

  def index
    @user = User.new
  end

  def show
    @gomi = Gomi.all
    p @gomi
    puts @gomi
  end

  def create
    @gomi = Gomi.new
    @gomi.name = params[:gomi][:name]
    @gomi.every = params[:gomi][:every]
    @gomi.save
    redirect_to '/gomi/show'
  end

end
