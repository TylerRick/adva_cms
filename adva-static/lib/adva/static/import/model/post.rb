module Adva
  class Static
    class Import
      module Model
        class Post < Base
          PERMALINK = %r((?:^|/)(\d{4})(?:\-|\/)(\d{1,2})(?:\-|\/)(\d{1,2})(?:\-|\/)(.*)$)

          class << self
            def recognize(sources)
              posts = sources.select { |source| source.path =~ PERMALINK }
              sources.replace(sources - posts)
              posts.map { |post| new(post) }
            end

            def permalink?(path)
              path.to_s =~ PERMALINK
            end

            def strip_permalink(source)
              path = source.to_s.gsub(Post::PERMALINK, '')
              path = 'index' if path.blank?
              Source.new(path, source.root)
            end
          end

          def initialize(path)
            super(path)
            load
          end

          def attribute_names
            [:site_id, :section_id, :title, :body, :created_at] # TODO created_at should be published_at
          end

          def record
            @record ||= section.posts.by_permalink(*permalink).all.first || section.posts.build
          end

          def section
            @section ||= Blog.new(section_source).record
          end

          def site_id
            section.site_id.to_s
          end

          def section_id
            section.id.to_s
          end

          def section_source
            @section_path ||= begin
              source = self.class.strip_permalink(self.source).find
              source = Source.new(source.join('index'), source.root).find if source.path.empty?
              source
            end
          end

          def slug
            @slug ||= SimpleSlugs::Slug.new(title).to_s
          end

          def title
            @title ||= source.basename.gsub(Post::PERMALINK) { $4 }.titleize
          end

          def permalink
            source.to_s.match(PERMALINK).to_a[1..-2] << slug
          end

          def created_at
            @created_at ||= DateTime.civil(*permalink[0..-2].map(&:to_i))
          end
        end
      end
    end
  end
end