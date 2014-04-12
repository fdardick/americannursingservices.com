# Represents a single job posting.
class JobPost

  attr_accessor :id
  attr_accessor :location
  attr_accessor :title
  attr_accessor :employment_type
  attr_accessor :description
  attr_accessor :date_added

  def initialize(id, location, title, employment_type, description, date_added)
    @id = id
    @location = location
    @title = title
    @employment_type = employment_type
    @description = description
    @date_added = date_added
  end

  # Sort by date for enumerable
  def <=>(other)
    return self.location <=> other.location
  end

  def to_s
    "#{@id}: #{@location}, #{@title}, #{@employment_type}, #{@date_added}"
  end
end
