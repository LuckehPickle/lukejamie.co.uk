require 'admin_authentication_helper'

class Admin::SupportArticlesController < ApplicationController

    include AdminAuthenticationHelper

    before_action :authenticate_user!
    layout 'admin'


    def index
        return if enforce_admin(current_user)

        query = params[:query].present? ? params[:query] : '*'
        @articles = SupportArticle.search query,
                                          page: params[:page],
                                          per_page: 20
    end


    def new
        return if enforce_admin(current_user)
        @article = SupportArticle.new
    end


    def create
        return if enforce_admin(current_user)
        @article = SupportArticle.new article_params

        if @article.save
            flash[:notice] = t('admin.support_article.create') % { title: @article.title }
            redirect_to admin_support_articles_path
        else
            render 'new'
        end
    end


    def edit
        return if enforce_admin(current_user)

        @article = SupportArticle.find_by! slug: params[:id]
    end


    def update
        return if enforce_admin(current_user)

        @article = SupportArticle.find_by! slug: params[:id]

        if @article.update article_params
            flash[:notice] = t('admin.support_article.update') % { title: @article.title }
            redirect_to admin_support_articles_path
        else
            render 'edit'
        end
    end


    def destroy
        return if enforce_admin(current_user)

        @article = SupportArticle.find_by! slug: params[:id]
        @article.destroy

        flash[:notice] = t('admin.support_article.delete') % { title: @article.title }
        redirect_to admin_support_articles_path
    end


    private

        def article_params
            params.require(:support_article).permit(
                :title,
                :category,
                :description,
                :body
            )
        end

end
