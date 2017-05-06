class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /users
  # GET /users.json
  def index
    @users = User.all
    @user = User.new
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    if User.all.size > 100
      respond_to do |format|
      format.html { redirect_to users_url, notice: 'いっぱい(っ◞‸◟c)いっぱい' }
      format.json { head :no_content }
      end
    else

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def login
    if params[:regist] == "登録"
      if User.find_by(name:params[:user][:name])
        flash[:alert] = "既に登録されているユーザー名です"
        @user = User.new
        puts "error"
        redirect_to users_path and return
      end
      create and return
    end

    puts "no regist"
    name = params[:user][:name]
    @user = User.find_by(name:name)
    if @user
      # login
      session[:id] = @user.id
      redirect_to gomis_path and return
    else
      # error
      flash[:alert] = "ユーザーが見つかりません"
      @user = User.new
      redirect_to users_path and return
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, :pushtime, :title)
    end
end
