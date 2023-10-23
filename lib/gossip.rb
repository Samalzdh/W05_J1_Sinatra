class Gossip
  require 'csv'
  attr_accessor :content, :author , :id
  def initialize(author, content)
    @author = author
    @content = content
  end
  def save
    CSV.open('./db/gossip.csv', 'ab') do |csv|
      csv << [@author, @content]
    end  
  end
  def self.all
    all_gossips = []
    CSV.read("./db/gossip.csv").each do |csv_line|
      all_gossips << Gossip.new(csv_line[0], csv_line[1])
    end
    return all_gossips
  end
  
  def self.find(id)
    data = all()
    id = id.to_i + 1
    if id - 1  < 0 || id > data.length
      return [nil, nil , nil]
    else 
      return [id.to_s,data[id-1].content,data[id-1].author]
    end
  end
  def self.update(author, content, id)
		gossip_array = self.all
		gossip_array[id.to_i].content = content
		gossip_array[id.to_i].author = author
		#erase the csv file
		CSV.open("./db/gossip.csv", 'w') {|file| file.truncate(0) }
		#rewrite the file with the modif
		gossip_array.each do |gossip|
			gossip.save
		end	
	end
  
end
