# coding: UTF-8

module MicropostsHelper

  def show_timestamp(micropost)
    if micropost.created_at.today?
      micropost.created_at.strftime("%H:%M")
    else
      micropost.created_at.strftime("%F")
    end
  end

end
