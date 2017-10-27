# frozen_string_literal: true
class PresenterGenerator < Rails::Generators::NamedBase
  source_root File.expand_path('../templates', __FILE__)

  desc 'Generate acts_as_api model presenter'
  def create_presenter_file
    create_file "app/presenters/#{name}_presenter.rb", <<-FILE
module #{class_name}Presenter
  extend ActiveSupport::Concern

  included do
    acts_as_api

    ## ------------------ APIs Accessible ------------------- ##

    api_accessible :base do |t|
      t.add :id
    end

    ## ----------------------- Users ------------------------ ##

    api_accessible :v1_index, extend: :base

    api_accessible :v1_show, extend: :v1_index

    ## ----------------------- Admin ------------------------ ##

    api_accessible :v1_admin_index, extend: :base

    api_accessible :v1_admin_show, extend: :v1_admin_index
  end
end
    FILE
  end
end
