class CatalogueController < ApplicationController
  skip_before_action :verify_authenticity_token
  def index
    @tags = ((params[:tags] || "")+"").split(/,/)
    @tags ||= []
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

  def item
    @sock_id = params[:sock_id]
    @sock = SockGetter.call(@sock_id)
    render json: @sock
  end
end