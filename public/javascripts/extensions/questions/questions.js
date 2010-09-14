var QuestionForm = Class.create({
  $form: null,

  initialize: function(element) {
    this.$form = $(element);
  }
});

var QuestionFormBehavior = Behavior.create({
  initialize: function() {
    new QuestionForm(this.element);
  }
});