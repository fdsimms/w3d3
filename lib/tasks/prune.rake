task :prune => :environment do
  ShortenedUrl.prune
end
