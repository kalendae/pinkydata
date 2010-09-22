class User
  attr_accessor :uid, :session_key, :token

  def self.for params
    u = User.new
    u.uid = params[:fb_sig_user] || params[:uid] 
    u.session_key = params[:fb_sig_session_key]
    u.token = OAUTH.get_token_from_session_key(u.session_key) if u.session_key
    u.token ||= params[:token]
    u
  end

  def pic args
    graph.get_local_picture(self.uid, args)
  end

  def friends
    @friends ||= retrieve_friends
  end

  def method_missing(method, *args, &block)
    @profile ||= graph.get_object(self.uid)
    if @profile[method.to_s.downcase]
      @profile[method.to_s.downcase]
    else
      super
    end
  end

  private

  def graph
    @graph ||= Koala::Facebook::GraphAPI.new(self.token)
  end

  def retrieve_friends
  end

end
