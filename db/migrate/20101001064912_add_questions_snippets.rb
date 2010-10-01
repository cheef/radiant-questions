class AddQuestionsSnippets < ActiveRecord::Migration
  def self.up

    Snippet.new do |s|
      s.name    = "random_question_reply_form"
      s.content = <<CONTENT
<r:question:find scope="random">
  <r:question:if_exists>
    <div class="l-question-reply-form">
      <r:question:reply:form>
        <h2 class="b-question-body"><r:question:body /></h2>
        <ul class="b-question-answers">
          <r:answers:each>
            <li class="b-question-answer">
              <r:answer:input />
              <r:answer:label />
            </li>
          </r:answers:each>
        </ul>
        <r:submit value="I'm answered!" />
      </r:question:reply:form>
    </div>
  </r:question:if_exists>
</r:question:find>
CONTENT
    end.save

  end

  def self.down
    ["random_question_reply_form"].each do |snippet|
      Snippet.find_by_name(snippet).destroy rescue p "Could not destroy snippet #{snippet}"
    end
  end
end
