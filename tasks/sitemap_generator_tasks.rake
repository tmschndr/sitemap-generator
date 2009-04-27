require File.join(File.dirname(__FILE__), '/../lib/sitemap_generator')

namespace :sitemap do

  desc "Generates the sitemap"
  task :generate do
    # TODO read configuration from a YAML file
    SitemapGenerator::Generator.generate 'config' do |host, data|
      Post.all(:order => 'created_at desc', :limit => 5000).each do |post|
        data.add post, 0.7, :monthly
      end

      Category.all(:order => 'created_at desc', :limit => 5000).each do |category|
        data.add category, 0.6, :weekly
      end

      Tag.all(:order => 'created_at desc', :limit => 5000).each do |tag|
        data.add tag, 0.5, :weekly
      end
      
      Brand.all(:order => 'created_at desc', :limit => 5000).each do |brand|
        data.add brand, 0.7, :weekly
      end
    end
  end

end
