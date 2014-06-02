# coding: UTF-8

class MicropostsController < ApplicationController
  before_action :set_micropost, only: [:show, :edit, :update, :destroy]
  # before_action :set_party, only: [:show, :edit, :update, :destroy]
  before_action :signed_in_user, only: [:create, :edit, :update, :destroy]
  # before_action :correct_user, only: :destroy

  # GET /microposts
  # GET /microposts.json
  def index
    @microposts = Micropost.all
  end

  # GET /microposts/1
  # GET /microposts/1.json
  def show

  end

  # GET /microposts/new
  def new
    @micropost = Micropost.new
  end

  # GET /microposts/1/edit
  def edit
  end

  # POST /microposts
  # POST /microposts.json
  def create
    @params = micropost_params
    @params[:user_id] = current_user.id
    @micropost = Micropost.new(@params)

    if @micropost.save
      flash[:success] = "게시글을 작성하였습니다!"
      redirect_to :back
      # format.html { redirect_to :back, notice: 'Micropost was successfully created.' }
      # format.json { render :show, status: :created, location: @micropost }
    else
      flash[:danger] = "게시글 작성에 실패하였습니다."
      redirect_to :back
      # redirect_to party_path(@params[:party_id])
      # format.json { render json: @micropost.errors, status: :unprocessable_entity }
    end
  end

  # PATCH/PUT /microposts/1
  # PATCH/PUT /microposts/1.json
  def update
    respond_to do |format|
      if @micropost.update(micropost_params)
        format.html { redirect_to @micropost, notice: 'Micropost was successfully updated.' }
        format.json { render :show, status: :ok, location: @micropost }
      else
        format.html { render :edit }
        format.json { render json: @micropost.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /microposts/1
  # DELETE /microposts/1.json
  def destroy
    if @micropost.destroy
      flash[:success] = "게시글을 삭제하였습니다."
      redirect_to :back
    else
      flash[:danger] = "게시글 삭제에 실패하였습니다."
      redirect_to :back
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_micropost
      @micropost = Micropost.find(params[:id])
    end

    def set_party
      @party = Party.find(params[:party_id])
    end

    def correct_user
      @micropost = current_user.microposts.find_by(id: params[:id])
      redirect_to root_url if @micropost.nil?
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def micropost_params
      params.require(:micropost).permit(:content, :party_id)
    end

end
