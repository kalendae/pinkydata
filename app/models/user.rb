class User
  attr_accessor :uid, :token

  def self.for params
    u = User.new
    u.uid = params[:user_id]
    u.token = params[:oauth_token]
    u
  end

  def pic args
    graph.get_local_picture(self.uid, args)
  end

  def pic_for uid, args
    graph.get_local_picture(uid, args)
  end

  def friends
    @friends ||= graph.get_connections(self.uid, 'friends')
  end

  def likes
    @likes ||= Like.for(graph.get_connections(self.uid, 'likes'))
  end

  def method_missing(method, *args, &block)
    @profile ||= graph.get_object(self.uid)
    if @profile[method.to_s.downcase]
      @profile[method.to_s.downcase]
    else
      super
    end
  end

  def likes_intersecting_with friend
    friend.likes & self.likes
  end

  def likes_unique_against friend
    self.likes - friend.likes
  end

  def likes_before friend
    likes_intersecting_with(friend).select{|l| l.created_time.present? and friend.likes.find{|fl| fl == l}.created_time.to_i > l.created_time.to_i}
  end

  def clear_for_placement_into_cookies
    @likes = nil
    @graph = nil
    @profile = nil
    @friends = nil
  end

  private

  def graph
    @graph ||= Koala::Facebook::API.new(self.token)
  end

end
