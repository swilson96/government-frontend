class PatternsController < ContentItemsController
  layout 'patterns'

  def show
    load_content_item
    load_documentation
    # set_up_education_navigation_ab_testing
    # set_expiry
    # set_access_control_allow_origin_header if request.format.atom?
    # set_guide_draft_access_token if @content_item.is_a?(GuidePresenter)
    # render_template

    @partial_name = params[:pattern]
  end

private

  def load_documentation
    doc_files = Rails.root.join('app', 'views', 'shared', 'docs', '*.yml')
    file = Dir[doc_files].find {|f| f.include? (params[:pattern]) }

    @documentation = YAML::load_file(file)
  end

  def load_content_item
    schema = GovukSchemas::Schema.find(frontend_schema: schema_name)
    random_example = GovukSchemas::RandomExample.new(schema: schema).payload

    # Use provided schema_name rather than a randomly generated one
    random_example['schema_name'] = schema_name
    @content_item = present(random_example)
  end

  def schema_name
    "answer"
  end

  def set_expiry
  end
end
