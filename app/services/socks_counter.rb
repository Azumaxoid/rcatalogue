class SocksCounter
  include Service

  def initialize(tags)
    @tags = tags
  end

  def call
    if  @tags.length > 0
    sql = <<-"EOS"
SELECT count(*) FROM ( 
  SELECT socks.sock_id FROM socks 
  INNER JOIN sock_tags ON socks.sock_id = sock_tags.sock_id 
  INNER JOIN tags ON sock_tags.tag_id = tags.tag_id 
  WHERE tags.name in (?,?,?,?,?,?,?,?,?,?,?,?) GROUP BY socks.sock_id 
  ORDER BY socks.sock_id
) AS t
EOS
    param = []
    for i in 0..11
      param[i] = @tags[i] || '_'
    end
    sanitize_sql = ActiveRecord::Base.send(:sanitize_sql_array, [sql, param].flatten)
    result = ActiveRecord::Base.connection.select_all(sanitize_sql).to_a
    return result
    else
      sql = "SELECT count(*) FROM socks ORDER BY socks.sock_id"
      result = ActiveRecord::Base.connection.select_all(sql).to_a
      return result
    end
  end

end