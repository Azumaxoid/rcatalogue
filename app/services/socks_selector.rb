class SocksSelector
  include Service

  def initialize(tags, pageNum, pageSize, order)
    @tags = tags
    @pageNum = pageNum
    @pageSize = pageSize
    @order = order
  end

  def call
    @socks = [];
    if  @tags.length > 0
      sql = <<-"EOS"
      SELECT socks.* FROM socks 
      INNER JOIN sock_tags ON socks.sock_id = sock_tags.sock_id 
      INNER JOIN tags ON sock_tags.tag_id = tags.tag_id 
      WHERE tags.name in (?,?,?,?,?,?,?,?,?,?,?,?) limit ? OFFSET ?
     EOS
      param = []
      for i in 0..11
        param[i] = @tags[i] || '_'
      end
      param.append(@pageSize)
      param.append(@pageNum - 1)
      sanitize_sql = ActiveRecord::Base.send(:sanitize_sql_array, [sql, param].flatten)
      Rails.logger.info(sanitize_sql)
      @socks = Sock.find_by_sql(sanitize_sql)
    else
      @socks = Sock.order(:sock_id).limit(@pageSize).offset((@pageNum - 1) * @pageSize)
    end

    return @socks.map{|sock| {
      "id": sock.sock_id,
      "name": sock.name,
      "description": sock.description,
      "price": sock.price,
      "count": sock.count,
      "imageUrl": [sock.image_url_1, sock.image_url_2]
    }}
  end

end