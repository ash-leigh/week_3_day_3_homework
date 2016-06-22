class Store

  attr_reader(:id, :name)

  def initialize(options, runner)
    @id = options['id'].to_i
    @name = options['name']
    @address = options['address']
    @stock_type = options['stock_type']
    @runner = runner
  end

  def save()
    sql = "INSERT INTO stores (name, address, stock_type) VALUES ('#{@name}', '#{@address}', '#{@stock_type}') RETURNING *"
    store_data = @runner.run(sql)
    @id = store_data.first['id'].to_i
  end

  def pets()
    sql = "SELECT * FROM pets WHERE store_id = #{@id}"
    pets_data = @runner.run(sql)
    pets = pets_data.map {|pet| Pet.new(pet, @runner)}
    return pets
  end

  def self.all(runner)
    sql = "SELECT * FROM stores"
    stores_data = runner.run(sql)
    stores = stores_data.map {|store| Store.new(store, runner)}
    return stores
  end

  #only runs if both pets associated with it are deleted first
  def self.delete_by_id(id, runner)
    sql = "DELETE FROM stores WHERE id = #{id}"
    runner.run(sql)
  end

  def self.select_by_id(id, runner)
    sql = "SELECT * FROM stores WHERE id = '#{id}'"
    store = runner.run(sql)
    return Store.new(store.first(), runner)
  end

  def update (options)
    if (options['name'])
      @name = options['name']
    end
    if (options['address'])
      @address = options['address']
    end
    if (options['stock_type'])
      @stock_type = options['stock_type']
    end
   
    store_id = options['id'].to_i

    sql = "UPDATE stores SET 
      name = '#{ @name }', 
      address = '#{ @address }',
      stock_type = '#{@stock_type}'
      WHERE id = #{ @id }"
      @runner.run(sql)
  end


end