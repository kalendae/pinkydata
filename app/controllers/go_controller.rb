class GoController < ApplicationController

  def choose
    respond_to do |format|
      format.html
    end
  end

  def result
    respond_to do |format|
      format.html
    end
  end

  def cb
    # code for handle oauth denial / authorize goes here
    # right now just redirect to choose
    redirect_to go_choose_path
  end

end
