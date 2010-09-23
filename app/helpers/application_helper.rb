module ApplicationHelper

  def square usr
    image_tag(usr.pic('type' => 'square'))   
  end

  def small_sq usr
    image_tag(usr.pic('type' => 'square'), :width => 25, :height => 25)
  end
  
end
