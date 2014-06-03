# coding: UTF-8

module ApplicationHelper
  # Returns the full title on a per-page basis.
  def full_title(page_title)
    base_title = t('app_title')
    if page_title.empty?
      base_title
    else
      "#{base_title} | #{page_title}"
    end
  end

  def show_timestamp(object)
    if object.created_at.today?
      object.created_at.strftime("%H:%M")
    else
      if object.created_at.year.equal? Date.today.year
        object.created_at.strftime("%m월 %d일")
      else
        object.created_at.strftime("%yy년 %m월 %d일")
      end
    end
  end

  def javascript(*files)
    content_for(:head) { javascript_include_tag(*files) }
  end

end