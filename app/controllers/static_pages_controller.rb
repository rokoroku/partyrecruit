# coding: UTF-8

class StaticPagesController < ApplicationController
  def home
    if signed_in?
      @user = current_user
      @parties = @user.parties
      render 'dashboard'
    else
      render 'home'
    end
  end

  def help
  end

  def about
  end

end
