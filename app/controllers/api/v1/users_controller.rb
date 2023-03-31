module Api
  module V1
    class UsersController < ApplicationController
      skip_before_action :authenticate_user!
      def index
        @users = User.all.order(:id)
        @users = @users.paginate(page: params[:page], per_page: params[:per_page])
        render json: @users, each_serializer: UserSerializer, status: :ok
      end
    end
  end
end
