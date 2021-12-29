class TagSelector
  include Service
  def call
    tags = Tag.all
    m = Thread::Mutex.new
    result = []
    sql = "SELECT count(*) as count FROM(SELECT sock_tags.sock_id FROM sock_tags WHERE tag_id = ? LIMIT 100) as t;"
    threads = tags.map do |tag|
      Thread.new do
        ActiveRecord::Base.connection_pool.with_connection do
          sanitize_sql = ActiveRecord::Base.send(:sanitize_sql_array, [sql, tag.tag_id])
          @res = ActiveRecord::Base.connection.select_all(sanitize_sql).to_a
        end
        m.synchronize {
          result.append({ name: tag.name, count: @res[0]["count"] })
        }
      end
    end
    threads.map(&:join)
    result = result.sort{|a, b| a[:name] <=> b[:name] }
    return result
  end

end