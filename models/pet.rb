class Pet

  attr_reader(:id, :name, :type, :store_id)

  def initialize(options, runner)
    @id = options['id']
    @name = options['name']
    @type = options['type']
    @store_id = options['store_id']
    @runner = runner
  end

  def save()
    sql = "INSERT INTO pets (name, type, store_id) VALUES ('#{@name}', '#{@type}', '#{@store_id}') RETURNING *"
    @runner.run(sql)
  end

  def store()
    sql = "SELECT * FROM stores WHERE id = #{@store_id}"
    store_data = @runner.run(sql)
    store = Store.new(store_data.first, @runner)
    return store
  end

end