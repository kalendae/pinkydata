class GoController < ApplicationController

  session :off, :only => :set_third_party_cookie_fix

  def choose
    respond_to do |format|
      format.html
    end
  end

  def result
    @friend = User.for(:uid => params[:friend], :token => user.token, :expire => user.expire)
    respond_to do |format|
      format.html
    end
  end

  def cb
    # code for handle oauth denial / authorize goes here
    # right now just redirect to choose
    top_redirect_to APP_URL_ROOT 
  end

  # part of the fix for safari with third party cookie prevention 
  def set_third_party_cookie_fix
    cookies['safari_cookie_fix'] = params[:_session_id]
    redirect_to params[:redirect_to]  
  end

end
