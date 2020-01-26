module Api
  module V1
    class UsersController < ApplicationController
      before_action :authenticate_api_v1_user!

      def currentuser
        @user = current_api_v1_user
        render json: { status: 'SUCCESS', message: 'Loaded the user', data: @user}
      end
      
      def show
        @user = User.find_by(nickname: params[:nickname])
        json_data = {
          'user': {
            'name': @user.name,
            'nickname': @user.nickname,
            'image': @user.image,
            'release': @user.status,
          }
        }
        render json: { status: 'SUCCESS', message: 'Loaded the user', data: json_data}
      end

      def destroy
        @user = current_api_v1_user
        @user.destroy
        render json: { status: 'SUCCESS', message: 'Delete the user', data: @user}
      end

      def answered_suki_posts
        @user = User.find_by(nickname: params[:nickname])
        @currentuser = current_api_v1_user
        answered_suki_posts_id = "SELECT post_id from likes WHERE user_id = :user_id and suki = 1"
        answered_suki_posts = Post.where("id IN (#{answered_suki_posts_id})", user_id: @user.id).page(params[:page] ||= 1).per(20).order('created_at DESC')
        page_length = Post.where("id IN (#{answered_suki_posts_id})", user_id: @user.id).page(params[:page] ||= 1).per(20).total_pages
        
        if @user.id == @currentuser.id || @user.released? then
          json_data = {
            'posts': answered_suki_posts,
            'page_length': page_length,
          }
        else
          json_data = {
            'posts': [],
            'page_length': 0
          }
        end

        render json: { status: 'SUCCESS', message: 'Loaded the answered_suki_posts', data: json_data}
      end

      def answered_kirai_posts
        @user = User.find_by(nickname: params[:nickname])
        answered_kirai_posts_id = "SELECT post_id from likes WHERE user_id = :user_id and suki = 0"
        answered_kirai_posts = Post.where("id IN (#{answered_kirai_posts_id})", user_id: @user.id).page(params[:page] ||= 1).per(20).order('created_at DESC')
        page_length = Post.where("id IN (#{answered_kirai_posts_id})", user_id: @user.id).page(params[:page] ||= 1).per(20).total_pages
        
        if @user.id == @currentuser.id || @user.released? then
          json_data = {
            'posts': answered_kirai_posts,
            'page_length': page_length,
          }
        else
          json_data = {
            'posts': [],
            'page_length': 0
          }
        end
        
        render json: { status: 'SUCCESS', message: 'Loaded the answered_kirai_posts', data: json_data}
      end

      def not_interested_posts
        @user = User.find_by(nickname: params[:nickname])
        posts_id = "SELECT post_id from likes WHERE user_id = :user_id and suki = 2"
        posts = Post.where("id IN (#{posts_id})", user_id: @user.id).page(params[:page] ||= 1).per(20).order('created_at DESC')
        page_length = Post.where("id IN (#{posts_id})", user_id: @user.id).page(params[:page] ||= 1).per(20).total_pages
        json_data = {
          'posts': posts,
          'page_length': page_length,
        }

        
        render json: { status: 'SUCCESS', message: 'Loaded the answered_kirai_posts', data: json_data}
      end


      def not_answered_posts
        @user = current_api_v1_user
        answered_posts_id = "SELECT post_id from likes WHERE user_id = :user_id"
        not_answered_posts = Post.where.not("id IN (#{answered_posts_id})", user_id: @user.id).order('RANDOM()').limit(10)
        json_data = {
          'posts': not_answered_posts,
        }
        
        render json: { status: 'SUCCESS', message: 'Loaded the not_answered_posts', data: json_data}

      end 
      
      def user_posts
        @user = User.find_by(nickname: params[:nickname])
        user_posts = Post.where(user_id: @user.id).page(params[:page] ||= 1).per(20).order('created_at DESC')
        page_length = Post.where(user_id: @user.id).page(params[:page] ||= 1).per(20).total_pages
        
        if @user.id == @currentuser.id || @user.released? then
          json_data = {
            'posts': user_posts,
            'page_length': page_length,
          }
        else
          json_data = {
            'posts': [],
            'page_length': 0
          }
        end
        render json: {status: 'SUCCESS', message: 'Loaded the user_posts', data: json_data}
      end

    end
  end
end

