module ApplicationHelper
  def will_paginate(collection_or_options = nil, options = {})
    if collection_or_options.is_a? Hash
      options, collection_or_options = collection_or_options, nil
    end
    unless options[:renderer]
      options = options.merge renderer: BootstrapRenderer
    end
    super(*[collection_or_options, options]).compact
  end

  class BootstrapRenderer < WillPaginate::ActionView::LinkRenderer
    private

    def html_container(html)
      tag :nav, tag(:ul, html, class: "pagination"), container_attributes
    end

    def page_number(page)
      tag :li, link(page, page, rel: rel_value(page), class: 'page-link'),
        class: (page == current_page ? 'page-item active' : 'page-item')
    end

    def previous_or_next_page(page, text, classname)
      tag :li, link(text, page || '#', class: 'page-link'),
        class: ['page-item', classname, ('disabled' unless page)].join(' ')
    end
  end
end
