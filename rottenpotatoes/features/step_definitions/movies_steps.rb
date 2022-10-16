
Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    Movie.create movie
  end
end

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.body is the entire content of the page as a string.
  expect(page.body.index(e1) < page.body.index(e2))
end

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  rating_list.split(', ').each do |rating|
    step %{I #{uncheck.nil? ? '' : 'un'}check "ratings_#{rating}"}
  end
end

Then /I should see all the movies/ do
  # Make sure that all the movies in the app are visible in the table
  Movie.all.each do |movie|
    step %{I should see "#{movie.title}"}
  end
end

# Reference:
# https://relishapp.com/rspec/rspec-expectations/docs/built-in-matchers/include-matcher
Then /the director of "(.*)" should be "(.*)"/ do |title, new_director|
  movie = Movie.find_by(title: title )
  # page = movie_path(movie)
  # puts page.body
  #Director:\n    Ridley Scott
  expect(page.body).to include new_director
end