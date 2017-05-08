class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /users
  # GET /users.json
  def index

    p @errors
    @users = User.all
    @user = User.new
    @errors = []
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

    if User.all.size > 50
      respond_to do |format|
        format.html { redirect_to users_path, flash[:alert] = "いっぱい(っ◞‸◟c)いっぱい" }
        format.json { head :no_content }
      end
    else

#      if User.find_by(name:params[:user][:name])
#        flash[:alert] = "既に登録されているユーザー名です"
#        @user = User.new
#        puts "error"
#        redirect_to users_path and return
#      end

#      respond_to do |format|
      if @user.save
        flash[:notice] = 'User was successfully created.'
#        format.html { render :new, notice: 'User was successfully created.' }
#        format.json { render :login, status: :created, location: @user }
        redirect_to root_path
      else
        puts "errrrrrrrrrrrrrrrrrrrrr"
        p @user.errors.full_messages
        flash[:alert] = @user.errors.full_messages
        render :new
#        format.html { render :new}
#        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
#      end

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
      redirect_to new_user_path and return
    end

    name = params[:user][:name]
    password = params[:user][:password]

    puts "name==="
    p password

    @errors = []
    @user = User.new

    if name.blank?
      @errors << "ユーザー名を入力してください．"
      render :index and return
    end

    @user = User.find_by(name:params[:user][:name])

    if @user
      if password.blank?
        @errors << "パスワードを入力してください．"
        render :index and return
      end
      if @user.authenticate(params[:user][:password])
        # login
        session[:id] = @user.id
        redirect_to gomis_path and return
      else
        puts "間違いt"
        @errors << "パスワードが間違っています"
        render :index and return
      end
    else
      @user = User.new
      # error
      @errors <<  "ユーザーが見つかりません"
      puts "error"
      p @errors
      render :index and return
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
    params.require(:user).permit(:name, :pushtime, :title, :password, :password_confirmation)
  end
end
