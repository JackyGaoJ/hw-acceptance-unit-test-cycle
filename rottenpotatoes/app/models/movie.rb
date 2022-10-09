class Movie < ActiveRecord::Base
  def self.share_director curr_title
    curr_director = Movie.find_by(title: curr_title).director
    if curr_title.nil?
      return nil
    else
      return Movie.where(director: curr_director)
    end

end
