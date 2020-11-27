# frozen_string_literal: true

require 'octokit'
CLIENT = Octokit::Client.new

def favourite_language
  puts 'Please enter a github username to lookup their favourite programming language:'
  name = gets.chomp
  begin
    repos = CLIENT.repos(name)
    languages = []
    if repos.any?
      repos.each do |r|
        language = r[:language]
        languages.push(language)
      end
    else
      puts 'Sorry, this user has no public repos that we can check!'
    end
    puts name + 's favourite programming langauge is most likely to be ' + languages.max_by { |i| languages.count(i) }
  rescue => e
    puts e.message, 'Sorry, we couldn`t find a github user with that name, please try again' and return
  end
end

puts favourite_language
