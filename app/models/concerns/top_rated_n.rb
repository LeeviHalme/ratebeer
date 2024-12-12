module TopRatedN
  extend ActiveSupport::Concern

  class_methods do
    def top_rated(n_elements)
      sorted_by_rating_in_desc_order = all.sort_by{ |b| -(b.average_rating || 0) }
      sorted_by_rating_in_desc_order.take(n_elements)
    end
  end
end
