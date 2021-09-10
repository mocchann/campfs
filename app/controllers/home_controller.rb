class HomeController < ApplicationController
  def top
    @fields = Field.joins(:reviews).group("field_id").order("avg(rate) desc").limit(3)
  end
end
