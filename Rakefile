task :chrometests do
  system 'rspec spec/chrome --format h > firefoxOutput.html'
end
task :tests do
  system 'rspec spec/firefox --format h > chromeOutput.html'
end
