require 'feedjira'
module Jekyll
  class MediumPostDisplay < Generator
    safe true
    priority :high
def generate(site)
      jekyll_coll = Jekyll::Collection.new(site, 'blog_posts')
      site.collections['blog_posts'] = jekyll_coll
Feedjira::Feed.fetch_and_parse("https://medium.com/feed/louisville-metro-opi2").entries.each do |e|
        p "#{e.title}, published on Medium #{e.url} #{e}"
        title = e[:title]
        content = e[:content]
        guid = e[:url]
        path = "./_blog_posts/" + title + ".md"
        path = site.in_source_dir(path)
        doc = Jekyll::Document.new(path, { :site => site, :collection => jekyll_coll })
        doc.data['title'] = title;
        doc.data['feed_content'] = content;
        jekyll_coll.docs << doc
      end
    end
  end
end
