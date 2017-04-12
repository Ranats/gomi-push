class UserController < ApplicationController

  def create
#    @gomi = Gomi.new
#    @gomi.name = params[:gomi][:name]
#    @gomi.every = params[:gomi][:every]
#    @gomi.save
#    redirect_to '/gomi/show'
    @user = User.create(params[:session][:name])
    redirect_to gomi_index_path
  end

  def top
    @user = User.new
  end

  def login
    name = params[:user][:name]
    @user = User.find_by(name:name)
    if @user
      # login
      redirect_to gomi_index_path
    else
      # error
      flash[:alert] = "ユーザーが見つかりません"
      @user = User.new
      redirect_to user_root_path
    end
  end

  def new
    # code here
  end

end
