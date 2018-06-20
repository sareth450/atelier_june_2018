module Api
  module V1
    class BaseController < ACtionController::API
      before_action :check_login
  
      private
  
      def chceck_login
        render (json: { Error: 'acess denied' }, status: 401 ) unless current_user
      end
    end
  end
end
