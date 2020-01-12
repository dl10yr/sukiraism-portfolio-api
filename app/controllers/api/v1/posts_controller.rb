module Api
  module V1
    class PostsController < ApplicationController
      before_action :set_post, only: [:show, :update, :destroy]
      before_action :authenticate_api_v1_user!

      def index
        # posts = Post.page(params[:page] ||= 1).per(10).order('created_at DESC')
        posts = Post.all
        # page_length = Post.page(1).per(10).total_pages
        # json_data = {
        #   'posts': posts,
        #   'page_length': page_length,
        # }
        render json: { status: 'SUCCESS', message: 'Loaded posts', data: posts}
      end

      def show
        @user = @post.user
        json_data = {
          'post': @post,
          'user': {
            'name': @user.name,
            'nickname': @user.nickname,
            'image': @user.image
          }
        }
        render json: { status: 'SUCCESS', message: 'Loaded the post', data: json_data}
      end

      def create
        post = Post.new(post_params)
        if post.save
          render json: { status: 'SUCCESS', data: post}
        else
          render json: { status: 'ERROR', data: post.errors }
        end
      end

      def destroy
        @post.destroy
        render json: { status: 'SUCCESS', message: 'Delete the post', data: @post}
      end

      def update
      end

      private

      def set_post
        @post = Post.find(params[:id])
      end

      def post_params
        params.require(:post).permit(:content, :user_id)
      end

    end
  end
end  

