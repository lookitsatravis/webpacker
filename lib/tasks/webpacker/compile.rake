REGEX_MAP = /\A.*\.map\z/

namespace :webpacker do
  desc "Compile javascript packs using webpack for production with digests"
  task :compile => :environment do
    dist_dir = Rails.application.config.x.webpacker[:packs_dist_dir]
    result   = `WEBPACK_DIST_DIR=#{dist_dir} NODE_ENV=production ./bin/webpack --json`

    unless $?.success?
      puts JSON.parse(result)['errors']
      exit! $?.exitstatus
    end

    packs_path = Rails.root.join("public", dist_dir)
    packs_digests_path = Rails.root.join(dist_dir, 'digest.json')
    webpack_digests = JSON.parse(File.read(packs_digests_path))

    puts "Compiled digests for all packs in #{packs_digests_path}: "
    puts webpack_digests
  end
end

# Compile packs after we've compiled all other assets during precompilation
if Rake::Task.task_defined?('assets:precompile')
  Rake::Task['assets:precompile'].enhance do
    Rake::Task['webpacker:compile'].invoke
  end
end
