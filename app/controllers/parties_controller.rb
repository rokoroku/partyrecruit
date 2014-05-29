# coding: UTF-8

class PartiesController < ApplicationController
  before_action :set_party, only: [:show, :edit, :update, :destroy]

  def index
    @parties = Party.all
  end

  def new
    @party = Party.new
  end

  def create
    @party = Party.new(party_params)
    if @party.save
      @party.participate!(current_user)
      @party.leader!(current_user)
      flash[:success] = "파티가 생성되었습니다!!"
      redirect_to @party
    else
      flash[:danger] = "오류가 발생했습니다."
      render 'new'
    end
  end

  def show
  end

  def join
    set_party
    if @party.participate!(current_user)
      flash[:success] = "파티에 가입되었습니다."
      redirect_to @party
    else
      flash[:danger] = "가입에 실패하였습니다."
      redirect_to party_path
    end
  end

  def edit
  end

  def update
    if @party.update(party_params)
      flash[:success] = "파티 정보가 수정되었습니다."
      redirect_to @party
    else
      flash[:danger] = "오류가 발생했습니다."
      render 'edit'
    end
  end

  def destroy
    @party.destroy
    respond_to do |format|
      format.html { redirect_to parties_url, notice: 'Party was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_party
      @party = Party.find(params[:id])
    end

    def party_params
      params.require(:party).permit(:name, :user_limit, :description)
    end
end
