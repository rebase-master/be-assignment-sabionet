class CustomSessionsController < Devise::SessionsController
  def create
    super do |resource|
      if request.format.json?
        render json: { redirect_url: root_path }
        return
      end
    end
  end
end
