require "launchy"

task :default do
  sh %( fuser -k 4567/tcp ) rescue nil
  Thread.new do
    sh %( ruby site/ruby/server.rb )
  end
  sleep(1)
  Launchy.open("#{__dir__}/site/index.html") do |exception|
    puts "Attempted to open failed because #{exception}\n"
  end
  loop{sleep(3600)}
end
