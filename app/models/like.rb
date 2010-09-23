class Like
  attr_accessor :uid, :name, :category, :created_time

  def self.for raw_likes
    raw_likes.collect{|l| Like.new(l)}.to_set
  end

  def initialize raw_data
    self.uid = raw_data['id']
    self.name = raw_data['name']
    self.category = raw_data['category']
    self.created_time = Time.parse raw_data['created_time']
  end

  def <=>(other)
    self.uid <=> other.uid
  end

  def ==(other)
    self.uid == other.uid
  end

  def eql?(other)
    self.uid.eql?(other.uid)
  end

  def hash
    self.uid.hash
  end

end
