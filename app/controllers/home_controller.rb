class HomeController < ApplicationController

  def dashboard
  end


  def landing
  end


  def static
    render static_pagename
  end


private

  def static_pagename
    request.fullpath.sub(/^\//, "")
  end

end
