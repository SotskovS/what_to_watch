class Film
  def initialize(title, director, year)
    @title = title
    @director = director
    @year = year
  end

  def director
    @director
  end

  def title
    @title
  end

  def year
    @year
  end

  def info
    "#{@title}, #{year}г. - реж.#{@director}"
  end  
end
