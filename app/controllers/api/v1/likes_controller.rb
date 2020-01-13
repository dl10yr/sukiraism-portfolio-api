module Api
  module V1
    class LikesController < ApplicationController
      before_action :authenticate_api_v1_user!
      before_action :set_like, only: [:show, :destroy, :update,]

      def index
        likes = Like.order(created_at: :desc)
        render json: { status: 'SUCCESS', message: 'Loaded posts', data: likes }
      end

      def show
        if @like.nil? then
            data = {
              updated_at: 3,
              suki: 3
            }
          render json: { status: 'SUCCESS', message: 'Loaded the like', data: data }
        else 
          render json: { status: 'SUCCESS', message: 'Loaded the like', data: @like }
        end
        
      end


      def create
        like = Like.new(like_params)
        if like.save
          @post = Post.find(params[:post_id])
          @user = @post.user
          @like = Like.find_by(user_id: @user.id, post_id: params[:post_id])
          json_data = {
            'post': @post,
            'user': {
              'name': @user.name,
              'nickname': @user.nickname,
              'image': @user.image
            },
            'like': @like
          }
          render json: { status: 'SUCCESS', data: json_data}
        else
          render json: { status: 'ERROR', data: like.errors }
        end
      end

      def destroy
        @like.destroy
        render json: { status: 'SUCCESS', message: 'Delete the post', data: @like}
      end

      def update
        data = {
          'user_id': @user.id,
          'post_id': params[:post_id],
          'suki': params[:suki]
        }
        if @like.update(data)
          @post = Post.find(params[:post_id])
          @user = @post.user
          json_data = {
            'post': @post,
            'user': {
              'name': @user.name,
              'nickname': @user.nickname,
              'image': @user.image
            },
            'like': @like
          }
          render json: { status: 'SUCCESS', message: 'Updated the post', data: json_data }
        else
          render json: { status: 'SUCCESS', message: 'Not updated', data: @like.errors }
        end
      end


      private

      def set_like
        @user = User.find_by(id: current_api_v1_user.id)
        @like = Like.find_by(user_id: @user.id, post_id: params[:post_id])
      end

      def like_params
        params.require(:like).permit(:post_id, :user_id, :suki)
      end

    end
  end
end

