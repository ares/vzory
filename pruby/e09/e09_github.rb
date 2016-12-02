require 'rubygems'
require 'bundler/setup'

require 'rest-client'
require 'json'
require 'rainbow/ext/string'
require 'highline'

cli = HighLine.new
while true
  org = cli.ask "Github organization/user?"
  exit(0) if org == 'quit'

  repo = cli.ask "Github repo name?"
  exit(0) if repo == 'quit'
  
  response = JSON.parse(RestClient.get("https://api.github.com/repos/#{org}/#{repo}/branches"))
  response.each do |branch|
    puts branch['name'].color :green
  end

end
