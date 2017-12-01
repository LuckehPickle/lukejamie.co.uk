class Admin::SupportArticlesController < ApplicationController

    before_action :authenticate_user!
    layout 'admin'


    # GET /admin/support
    def index
        @articles = SupportArticle.order(updated_at: :desc).page(params[:page]).per(20)
    end


    # GET /admin/support/search
    def search
        query = params[:query].present? ? params[:query] : '*'
        @articles = SupportArticle.search query,
                                          fields: [:title, :body],
                                          order: {
                                              _score: :asc,
                                              updated_at: :asc
                                          },
                                          page: params[:page],
                                          per_page: 20
        render 'index'
    end


    # GET /admin/support/new
    def new
        @article = SupportArticle.new
    end


    # POST /admin/support
    def create
        @article = SupportArticle.new article_params

        if @article.save
            flash[:notice] = t('admin.support_article.create') % { title: @article.title }
            redirect_to admin_support_articles_path
        else
            render 'new'
        end
    end


    # GET /admin/support/:id/edit
    def edit
        @article = SupportArticle.find_by! slug: params[:id]
    end


    # PUT /admin/support/:id
    def update
        @article = SupportArticle.find_by! slug: params[:id]

        if @article.update article_params
            flash[:notice] = t('admin.support_article.update') % { title: @article.title }
            redirect_to admin_support_articles_path
        else
            render 'edit'
        end
    end


    # DELETE /admin/support/:id
    def destroy
        return if enforce_admin(current_user)

        @article = SupportArticle.find_by! slug: params[:id]
        @article.destroy

        flash[:notice] = t('admin.support_article.delete') % { title: @article.title }
        redirect_to admin_support_articles_path
    end


    # DELETE /admin/support/delete
    def destroy_many
        objects = params[:ids].split(',')
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
