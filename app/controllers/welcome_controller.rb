class WelcomeController < ApplicationController

  def index
  end

  def say
    # views/welcome/say.html.erb
    if request.xhr?
      render :layout => false
    else
      render
    end
  end

end
