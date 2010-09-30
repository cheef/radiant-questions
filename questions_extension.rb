# Uncomment this if you reference any of your controllers in activate
# require_dependency 'application_controller'

class QuestionsExtension < Radiant::Extension
  version "1.0"
  description "Describe your extension here"
  url "http://github.com/cheef/radiant-questions"
  
  define_routes do |map|
    map.namespace :admin, :member => { :remove => :get } do |admin|
      admin.resources :questions
    end

    map.resources :questions, :only => [:reply], :member => {:reply => :post}
  end
  
  def activate
    add_tab
    add_tags
  end

  protected

    def add_tab

      if respond_to?(:tab)
        tab 'Content' do
          add_item "Questions", "/admin/questions", :after => "Pages"
        end
      else
        admin.nav[:content] << admin.nav_item(:questions, 'questions.tab', '/admin/questions')
      end
    end

    def add_pages_regions; end

    def add_tags
      Page.send :include, QuestionsTags
    end
end
