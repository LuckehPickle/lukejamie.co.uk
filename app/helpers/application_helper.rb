module ApplicationHelper

    ##
    # Renders the given +text+ as markdown.
    #
    # Params:
    # +text+::Text to render as markdown.
    def markdown (text)
        renderer = Redcarpet::Render::HTML.new

        markdown = Redcarpet::Markdown.new(
            renderer,
            no_intra_emphasis: true,
            tables: true,
            fenced_code_blocks: true,
            autolink: true,
            disabled_indented_code_blocks: true,
            strikethrough: true,
            space_after_headers: true,
            superscript: true,
            underline: true,
            footnotes: true
        )

        markdown.render(text).html_safe
    end


    ###
    # Renders a search field for the given +url+.
    #
    # Params:
    # +url+::URL to post query to.
    # +placeholder+::Search input's placeholder text.
    def render_search (url, placeholder)
        render partial: 'application/search',
               locals: {
                   url: url,
                   placeholder: placeholder
               }
    end


    ###
    # Renders a new list header. The given block is used to poulate any bulk
    # actions.
    #
    # Params:
    # +bulk_actions+::A block defining related bulk actions.
    def render_list_header (&bulk_actions)
        render partial: 'application/list-header',
               locals: { bulk_actions: bulk_actions }
    end

end
