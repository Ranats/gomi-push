class GomiController < ApplicationController

#  include SessionsHelper

  def gomi_params
    params.require(:gomi).permit(
        gomis_attributes: [:id, :name, :_destroy]
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
#    @user.gomis.build
    puts "gomis-----"
    @user.gomis.each do |gomi|
      p gomi
    end

    puts "gomi itirann-----"
    Gomi.all.each do |gomi|
      p gomi
    end
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

#    raise ActiveRecord::Rollback

    Gomi.delete_all(:user_id => current_user.id)

    puts "params:"

    # Todo
    # 一旦全部削除する？
    # or 上からID振ってID順に||=で更新とか

    data = ActionController::Parameters.new(params[:user][:gomis_attributes])


    puts "data------"
    data.each do |d|
      p d
    end

    puts "data------"

    keys = [:mon, :tues, :wed, :thurs, :fri, :sat, :sun]

    data.each do |id, gomi|
      if gomi[:_destroy]
        next
      end
      @gomi = Gomi.new
      @gomi.user_id = current_user.id

      @gomi.name = gomi[:name]

#      @gomi.every = (gomi[:every] == 1) ? true : false
      @gomi.every = gomi[:every]

#      if gomi[:every] == 1
        # どうにかして
        # その日が来たらチェックして更新して…
        @gomi.start_date = gomi[:start_date]
#      end

      keys.each do |key|
#        @gomi[key] = check(gomi[key])
        @gomi[key] = gomi[key]
      end

      unless @gomi.save
        flash[:alert] = @gomi.errors.full_messages
      end
    end

    redirect_to gomi_index_path
  end

end
