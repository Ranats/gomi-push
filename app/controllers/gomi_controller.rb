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
    p @user

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

    @user = current_user
    @user.pushtime_h = params[:user]["pushtime_h(4i)"].to_i
    @user.pushtime_m = params[:user]["pushtime_h(5i)"].to_i
    @user.save

    flash[:notice] = nil

    Gomi.delete_all(:user_id => current_user.id)

    puts "params:"

    data = ActionController::Parameters.new(params[:user][:gomis_attributes])

    puts "data------"
    data.each do |d|
      p d
    end

    puts "data------"

    keys = [:mon, :tues, :wed, :thurs, :fri, :sat, :sun]

#    gomis = []

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

#      gomis << @gomi

      unless @gomi.save
        puts "失敗〜〜〜〜〜〜〜〜〜〜〜〜〜〜〜〜〜〜〜"
        flash[:alert] = @gomi.errors.full_messages
       # 登録失敗時に入力データを保持する
        puts "gomi"
        p gomi
        @user.gomis.build(gomi)
#        @user.save

        flash[:notice] = nil
        render action: 'index' and return

#        @user = User.new(params[:user][:gomis_attributes])
#        attr = params.require(:user).permit(:name)
#        @gomi = Gomi.new(params.require(:user).permit(:name))
#        @gomi.save
      else
        puts "更新〜〜〜〜〜〜〜〜〜〜〜〜〜〜〜〜〜〜〜"
        flash[:notice] = "更新しました"
      end

    end

=begin
    result = Gomi.import gomis

    puts "result"
    p result
    p result[:failed_instances]
    if result[:failed_instances].blank?
      # 成功
      flash[:notice] = "更新しました"
    else
      # 失敗
      res = result[:failed_instances].first
      puts "res"
      attr = res[:name]
#      attr = Hash[]
      p attr
      @user = current_user
#      result[:failed_instances].each do |attr|
#        @user = User.new({name:attr})
      p @user
      render action: 'index' and return
#      end
      end
=end


    redirect_to gomi_index_path
  end

end
