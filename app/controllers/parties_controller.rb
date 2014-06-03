# coding: UTF-8

class PartiesController < ApplicationController
  before_action :set_party, only: [:show, :edit, :update, :destroy, :join, :leave]
  before_action :correct_user, only: [:show, :edit, :leave]

  def index
    @parties = Party.all
    @active_parties = Party.where recruiting: true
    # @parties = Party.all
  end

  def new
    @party = Party.new
  end

  def create
    param = party_params
    param[:recruiting] = true

    @party = Party.new(param)
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
    if @party.participate!(current_user)
      Micropost.new({party_id: @party.id, content: current_user.id.to_s + " joined"}).save
      flash[:success] = "파티에 가입되었습니다."
      redirect_to @party
    else
      flash[:danger] = "가입에 실패하였습니다."
      redirect_to party_path
    end
  end

  def leave
    wasLeader = @party.leader.id.equal?(current_user.id)

    if @party.leave!(current_user)
      if (@party.users.length == 0)
        @party.destroy!
        flash[:success] = "파티가 해체되었습니다."
      else
        @party.leader!(@party.users.first) if wasLeader
        Micropost.new({party_id: @party.id, content: current_user.id.to_s + " leaved"}).save
        flash[:success] = "파티를 탈퇴하였습니다."
      end
      redirect_to root_path
    else
      flash[:danger] = "탈퇴에 실패하였습니다. 잠시 후 다시 시도하세요."
      redirect_to @party
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

  def update_status
    @party = Party.find(params[:id])
    @participate_info = current_user.participate_info(@party)
    if @participate_info.update(status_msg: params[:content])
      flash[:success] = "상태메세지가 수정되었습니다."
      redirect_to @party
    else
      flash[:danger] = "오류가 발생했습니다."
      redirect_to @party
    end
  end

  def destroy
    if @party.destroy
      flash[:success] = "파티가 해체되었습니다."
      redirect_to root_url
    end
  end

  private
  def set_party
    @party = Party.find(params[:id])
  end

  def correct_user
    unless @party.participate?(current_user)
      flash[:danger] = "권한이 없습니다."
      redirect_to root_url
    end
  end

  def party_params
    params.require(:party).permit(:name, :user_limit, :description, :location_longitude, :location_latitude, :recruiting)
  end
end
