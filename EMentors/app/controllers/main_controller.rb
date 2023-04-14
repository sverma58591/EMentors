class MainController < ApplicationController
  def index
    @courses = Course.all
  end
end
