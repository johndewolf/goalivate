module ApplicationHelper

  def random_quotes
    quotes = [
      "\"You are never too old to set another goal or to dream a new dream.\" C.S. Lewise",
      "\"The best revenge is massive success.\" Frank Sinatra",
      "\"A goal is a dream with a deadline.\" Napoleon Hill" ]

    quotes.sample
  end
end
