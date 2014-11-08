# coding: UTF-8

module PartiesHelper
  def category_list
    ['취미', '운동', '식사', '스터디', '공연', '영화', '봉사', '기타']
  end

  def print_remaining_time(ended_at)
    unless ended_at.nil?
      remaining = (ended_at - Time.now)/60 + 0.5
      if remaining >= 60
        (remaining/60).to_i.to_s << "시간 " << (remaining%60).to_i.to_s << "분"
      else
        remaining.to_i.to_s << "분"
      end
    end
  end
end
