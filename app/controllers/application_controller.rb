class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :facebook_auth_check
  before_filter :session_check



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

  def session_check
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

end
