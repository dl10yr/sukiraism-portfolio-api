module Api
  module V1
    class PostsController < ApplicationController
      before_action :set_post, only: [:show, :update, :destroy]
      before_action :authenticate_api_v1_user!

      def index
        posts = Post.page(params[:page] ||= 1).per(20).order('created_at DESC')
        page_length = Post.page(1).per(20).total_pages
        json_data = {
          'posts': posts,
          'page_length': page_length,
        }
        render json: { status: 'SUCCESS', message: 'Loaded posts', data: json_data}
      end

      def suki_index
        posts = Post.page(params[:page] ||= 1).per(20).order('suki_percent DESC NULLS LAST')
        page_length = Post.page(1).per(20).total_pages
        json_data = {
          'posts': posts,
          'page_length': page_length,
        }
        render json: { status: 'SUCCESS', message: 'Loaded posts', data: json_data}
      end

      def all_count_index
        posts = Post.page(params[:page] ||= 1).per(20).order('all_count DESC')
        page_length = Post.page(1).per(20).total_pages
        json_data = {
          'posts': posts,
          'page_length': page_length,
        }
        render json: { status: 'SUCCESS', message: 'Loaded posts', data: json_data}
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
          render json: { status: 'ERROR', data: post.errors.full_messages }
        end
      end

      def destroy
        @post.destroy
        render json: { status: 'SUCCESS', message: 'Delete the post', data: @post}
      end

      def update
      end

      def search
        posts = Post.where("content LIKE ?", "%#{params[:q]}%").page(params[:page] ||= 1).per(20).order('created_at DESC')
        page_length = Post.where("content LIKE ?", "%#{params[:q]}%").page(params[:page] ||= 1).per(20).total_pages
        json_data = {
          posts: posts,
          page_length: page_length,
        }
        render json: { status: 'SUCCESS', message: 'Loaded the posts', data: json_data}

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

