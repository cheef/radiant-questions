var QuestionForm = Class.create({
  form: null, answers: [],

  initialize: function(element) {
    this.form = $(element);
    this.parseForm();
    this.attachEvents();
  },

  attachEvents: function() {
    Event.addBehavior({
      '.b-add-answer-link': QuestionForm.Buttons.Behavior(this.form)
    });
  },

  addAnswer: function(element) {
    self.answers.push(new QuestionForm.Answer(element));
  },

  parseForm: function() {
    var self = this;
    $$('.b-answers-column .b-answer').each(function(element) {
      self.addAnswer(element);
    });
  }
});

QuestionForm.Behavior = Behavior.create({
  initialize: function() {
    new QuestionForm(this.element);
  }
});

QuestionForm.Buttons = {};
QuestionForm.Buttons.Behavior = Behavior.create({
  $form: null,

  initialize: function(form) {
    this.form = form;
  },

  onclick: function(e) {
    this.form.addAnswer();
  }
});

QuestionForm.Question = Class.create();

QuestionForm.Answer = Class.create({
  container: null, id: null, text: null,

  initialize: function(element) {
    this.container = element;
    console.log(element);
  }
});

Event.addBehavior({
  '.b-question-form': QuestionForm.Behavior()
});
