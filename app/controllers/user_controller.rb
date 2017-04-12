class UserController < ApplicationController

  def create
#    @gomi = Gomi.new
#    @gomi.name = params[:gomi][:name]
#    @gomi.every = params[:gomi][:every]
#    @gomi.save
#    redirect_to '/gomi/show'
    @user = User.create(name:params[:user][:name])
    flash[:notice] = "登録しました"
    session[:id] = @user.id
    redirect_to gomi_index_path
  end

  def top
    @user = User.new
  end

  def login
    if params[:regist] == "登録"
      create and return
    end

    name = params[:user][:name]
    @user = User.find_by(name:name)
    if @user
      # login
      session[:id] = @user.id
      redirect_to gomi_index_path
    else
      # error
      flash[:alert] = "ユーザーが見つかりません"
      @user = User.new
      redirect_to user_root_path
    end
  end

end
