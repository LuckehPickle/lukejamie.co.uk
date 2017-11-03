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

end
