class ApplicationController < ActionController::Base

  before_filter :session_check
  before_filter :facebook_auth_check
  after_filter :clear_user_object

  helper_method :user

  APP_PERMISSIONS = "user_likes,friends_likes"

  def facebook_auth_check
    if params[:signed_request]
      signed_request = HashWithIndifferentAccess.new(OAUTH.parse_signed_request(params[:signed_request]))
      if signed_request[:oauth_token].present? and signed_request[:user_id].present?
        session[:user] = User.for(signed_request)
        true
      else
        session[:user] = nil
        oauth_redirect
        false
      end
    else
      if session[:user].blank?
        oauth_redirect
        false
      else
        true
      end
    end
  end

  def oauth_redirect
    top_redirect_to OAUTH.url_for_oauth_code(:permissions => APP_PERMISSIONS)
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
