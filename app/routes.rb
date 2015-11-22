module Routes
  def self.routes
    cat_handler = CatHandler.new

    ROUTES.build do
      cats do
        name   :cats
        params %w(name karma vip)
        handlers do
          get_all cat_handler.get_cats
          post    cat_handler.create_cat
          get     cat_handler.get_cat
          put     cat_handler.update_cat
          delete  cat_handler.delete_cat
        end
      end

    end
  end
end
