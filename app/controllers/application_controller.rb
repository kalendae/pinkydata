class ApplicationController < ActionController::Base

  before_filter :session_check
  before_filter :facebook_auth_check
  after_filter :clear_user_object

  helper_method :user

  def facebook_auth_check
    if params[:fb_sig_user] and params[:fb_sig_session_key]
      session[:user] = User.for(params)
      true
    else
      if params[:fb_sig]
        session[:user] = nil
      end
      if session[:user].blank?
        top_redirect_to OAUTH.url_for_oauth_code(:permissions => "user_likes,friends_likes")
      else
        true
      end
    end
  end

  # part of the fix for safari with third party cookie prevention 
  def session_check
    cookies['safari_cookie_fix'] = 'cookie OK'
    true
  end

  def top_redirect_to(*args)
    @redirect_url = url_for(*args)
    render :layout => false, :inline => <<-HTML
      <html><head>
        <script type="text/javascript">
          window.top.location.href = "<%= @redirect_url %>".replace(/&amp;/gi,"&");
        </script>
        <noscript>
          <meta http-equiv="refresh" content="0;url=<%=h @redirect_url %>" />
          <meta http-equiv="window-target" content="_top" />
        </noscript>
      </head></html>
    HTML
  end

  def user
    session[:user]
  end

  def clear_user_object
    user.clear_for_placement_into_cookies if user
  end

end
