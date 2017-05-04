class GomisController < ApplicationController
  before_action :set_gomi, only: [:show, :edit, :update, :destroy]

  def gomi_params
    params.require(:gomi).permit(
        gomis_attributes: [:id, :name, :_destroy]
    )
  end

  # viewでもcurrent_userメソッドが使えるようになる．すごーい
  helper_method :current_user
  def current_user
    @current_user ||= User.find_by(id: session[:id])
  end

  # GET /gomis
  # GET /gomis.json
  def index
    @gomis = Gomi.all
  end

  # GET /gomis/1
  # GET /gomis/1.json
  def show
  end

  # GET /gomis/new
  def new
    @gomi = Gomi.new
  end

  # GET /gomis/1/edit
  def edit
  end

  # POST /gomis
  # POST /gomis.json
  def create
    @gomi = Gomi.new(gomi_params)

    respond_to do |format|
      if @gomi.save
        format.html { redirect_to @gomi, notice: 'Gomi was successfully created.' }
        format.json { render :show, status: :created, location: @gomi }
      else
        format.html { render :new }
        format.json { render json: @gomi.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /gomis/1
  # PATCH/PUT /gomis/1.json
  def update
    respond_to do |format|
      if @gomi.update(gomi_params)
        format.html { redirect_to @gomi, notice: 'Gomi was successfully updated.' }
        format.json { render :show, status: :ok, location: @gomi }
      else
        format.html { render :edit }
        format.json { render json: @gomi.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /gomis/1
  # DELETE /gomis/1.json
  def destroy
    @gomi.destroy
    respond_to do |format|
      format.html { redirect_to gomis_url, notice: 'Gomi was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_gomi
      @gomi = Gomi.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
#    def gomi_params
#      params.require(:gomi).permit(:name, :every, :start_date, :mon, :tues, :wed, :thurs, :fri, :sat, :sun, :user_id)
#    end
end
