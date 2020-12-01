# frozen_string_literal: true

require 'octokit'
CLIENT = Octokit::Client.new

def favourite_language
  puts 'Please enter a github username to lookup their favourite programming language:'
  name = gets.chomp
  repos = CLIENT.repos(name)
  languages = []
  if repos.any?
    repos.each do |r|
      language = r[:language]
      languages.push(language)
    end
  else
    puts 'Sorry, this user has no public repos that we can check!'
    new_turn?
  end
  puts name + '`s favourite programming langauge is most likely to be ' + languages.max_by { |i| languages.count(i) }
  new_turn?
rescue StandardError => e
  puts 'Sorry, we couldn`t find a github user with that name, please try again'
  new_turn?
end

def new_turn?
  puts 'Do you want another go?'
  go_again = gets.chomp
  if go_again[0] == 'y' || go_again[0] == 'Y'
    favourite_language 
  else
    return
  end
end

favourite_language