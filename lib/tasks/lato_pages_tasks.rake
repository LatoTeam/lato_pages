# Initialize module on project
desc 'Create pages.yml file for Lato configuration'
task :lato_pages_initialize do
  directory = core_getCacheDirectory
  FileUtils.cp "#{LatoPages::Engine.root}/config/example.yml", "#{Rails.root}/config/lato/pages.yml"
end
