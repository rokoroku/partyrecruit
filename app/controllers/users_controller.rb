# coding: UTF-8
class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /users
  # GET /users.json
  def index
    @users = User.all
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
    if @user.save
      sign_in @user
      flash[:success] = "회원이 되신 것을 진심으로 환영합니다!!"
      redirect_to @user
    else
      flash[:danger] = "오류가 발생했습니다."
      render 'new'
    end

    # respond_to do |format|
    #   if @user.save
    #     format.html { redirect_to @user, flash: {'success', "회원이 되신 것을 진심으로 환영합니다!"} }
    #     format.json { render :show, status: :created, location: @user }
    #   else
    #     format.html { render :new }
    #     format.json { render json: @user.errors, status: :unprocessable_entity }
    #   end
    # end

  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update

    if @user.update(user_params)
      flash[:success] = "회원 정보가 수정되었습니다."
      redirect_to @user
    else
      flash[:danger] = "오류가 발생했습니다."
      render 'edit'
    end

    # respond_to do |format|
    #   if @user.update(user_params)
    #     format.html { redirect_to @user, notice: 'User was successfully updated.'}
    #     format.json { render :show, status: :ok, location: @user }
    #   else
    #     format.html { render :edit }
    #     format.json { render json: @user.errors, status: :unprocessable_entity }
    #   end
    # end

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
    # 인터넷(외부)으로부터 받아들이는 parameter들의 white list.
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
end
