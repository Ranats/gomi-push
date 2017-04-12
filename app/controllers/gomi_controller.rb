class GomiController < ApplicationController

#  include SessionsHelper

  def gomi_params
    params.require(:gomi).permit(
        gomis_attributes: [:id, :_destroy]
    )
  end

  def current_user
    @current_user ||= User.find_by(id: session[:id])
  end

  helper_method :current_user

  def top
    puts "user---"
    p @user
    session[:id] = @user.id
  end

  def index
    @user = current_user
    @user.gomis.build
#    p @user.gomis
  end

  def show
    @gomi = Gomi.where(user_id: current_user.id)
    puts "class"
    p @gomi
    puts ""
  end

  def check(num)
    num==1 ? true : false
  end

  def create
    puts "params:"

    # Todo
    # 一旦全部削除する？
    # or 上からID振ってID順に||=で更新とか

    data = ActionController::Parameters.new(params[:user][:gomis_attributes])

    keys = [:mon, :tues, :wed, :thurs, :fri, :sat, :sun]

    data.each do |id, gomi|
      @gomi = Gomi.new
      @gomi.user_id = current_user.id

      @gomi.name = gomi[:name]

#      @gomi.every = (gomi[:every] == 1) ? true : false
      @gomi.every = gomi[:every]

      if gomi[:every] == 1
        # どうにかして
        # その日が来たらチェックして更新して…
        @gomi.start_date = gomi[:start_date]
      end

      keys.each do |key|
#        @gomi[key] = check(gomi[key])
        @gomi[key] = gomi[key]
      end

      @gomi.save
    end

    redirect_to gomi_index_path
  end

end
