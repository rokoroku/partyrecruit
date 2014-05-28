# coding: UTF-8
class SessionsController < ApplicationController

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      # 로그인 세션 처리
      sign_in user
      flash[:success] = "Hello, " + user.name + "!"
      redirect_to home_url
    else
      flash[:danger] = "이메일 또는 비밀번호가 잘못되었습니다."
      render 'signin'

    end
  end

  def destroy
    sign_out
    flash[:success] = "로그아웃 되었습니다."
    redirect_to home_url
  end

end
