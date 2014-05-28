# coding: UTF-8

class StaticPagesController < ApplicationController
  def home
    if signed_in?
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
