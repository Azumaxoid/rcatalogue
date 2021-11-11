class CatalogueController < ApplicationController
  skip_before_action :verify_authenticity_token
  def index
    @tags = (params[:tags]||",").split(",")
    @order = params[:order]
    @pageNum = (params[:page] || 1).to_i
    @pageSize = params[:size].to_i

    @socks = SocksSelector.call(@tags, @pageNum, @pageSize, @order)
    render json: @socks
  end

  def size
    @tags = params[:tags]
    @tags ||= []
    @socks = SocksSelector.call(@tags, nil, nil, nil)
    render json: { "size": @socks.size }
  end

  # 詳細画面が開かない問題対応中
  def item
    @sock_id = params[:sock_id]
    @sock = SockGetter.call(@sock_id)
    render json: @sock
  end
end