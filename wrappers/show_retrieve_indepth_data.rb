require_relative 'retrieve_indept_data.rb'

puts JSON.pretty_generate(get_indepth_items('sina'))
