module ApplicationHelper
  def render_stars(score)
    full_stars = (score / 10).clamp(0, 5) # Convert score to 1-5 stars
    empty_stars = 5 - full_stars

    # Generate full stars and empty stars
    full_star_icons = full_stars.times.map { content_tag(:i, nil, class: "bi bi-star-fill text-warning") }.join
    empty_star_icons = empty_stars.times.map { content_tag(:i, nil, class: "bi bi-star") }.join

    # Combine and return HTML-safe string
    (full_star_icons + empty_star_icons).html_safe
  end

  def edit_and_destroy_buttons(item)
    return if current_user.nil?

    edit = link_to('Edit', url_for([:edit, item]))
    del = button_to('Destroy', item,  method: :delete,
                                      form: { data: { turbo_confirm: "Are you sure ?" } },
                                      class: "btn btn-sm btn-danger")
    raw("#{edit} #{del}")
  end

  def round(num)
    number_with_precision(num, precision: 1)
  end
end
