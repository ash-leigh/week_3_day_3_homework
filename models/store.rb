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

end