namespace :tests do
  desc "Runs all Tests"
    task :all do
      system 'rspec spec/firefox --format h > reports/firefoxOutput.html'
      system 'rspec spec/chrome --format h > reports/chromeOutput.html'
    end
  
  desc "Runs Chrome Tests"
    task :chrome do
      system 'rspec spec/chrome --format h > reports/chromeOutput.html'
    end
  
  desc "Runs Firefox Tests"
    task :ff do
      system 'rspec spec/firefox --format h > reports/firefoxOutput.html'
    end
end