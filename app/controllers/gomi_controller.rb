class GomiController < ApplicationController

#  include SessionsHelper

  def gomi_params
    params.require(:gomi).permit(
        gomis_attributes: [:id, :_destroy]
    )
  end

  def current_user
    @current_user ||= User.find_by(id:session[:id])
  end

  helper_method :current_user

  def top
#    @user = User.new(name:"test")
    @user = User.find_by(id:1)
    if @user.nil?
      puts "nil"
      @user = User.new(name:"test")
      @user.save
    end

    p @user

    puts "user---"
    p @user
    session[:id] = @user.id
  end

  def index
    puts "user---"
    p @user
    @user = current_user
    puts "user---"
    p @user
#    @user.name = "test"
#    @user = current_user
   @user.gomis.build
    p @user.gomis
  end

  def show
#    @gomi = Gomi.all
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

    data = ActionController::Parameters.new(params[:user][:gomis_attributes])
    #p params[:user][:gomis_attributes]

    p data

    keys = [:mon,:tues,:wed,:thurs,:fri,:sat,:sun]

    data.each do |id,gomi|
      p gomi
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

    #    gomis = params[:user][:gomis_attributes]
    #    gomis.each do |gomi|
    #      p gomi[:name]
    #    end

    redirect_to '/gomi/show'
  end

end
