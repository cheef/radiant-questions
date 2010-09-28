var QuestionForm = Class.create({
  container: null, answers: [],

  initialize: function(element) {
    this.container = $(element);
    this.parseContainer();
    this.attachEvents();
  },

  attachEvents: function() {
    Event.addBehavior({
      '.b-add-answer-link': QuestionForm.AddButtons.Behavior(this)
    });
  },

  detectAnswer: function(container) {
    var answer = new QuestionForm.Answer(container);

    container.childElements().each(function(input) {
      answer.detectPossibleAttributes(input);
    });

    return answer;
  },

  parseContainer: function() {
    this.detectAnswers();
  },

  detectAnswers: function() {
    var self = this;
    $$('.b-answers-column .b-answer').each(function(answerContainer) {
      self.addAnswer(self.detectAnswer(answerContainer));
    });
  },

  addAnswer: function(answer) {
    return (answer ? this.answers.push(answer) : false);
  },

  removeAnswer: function(element) {
    alert('test');
  },

  buildAnswer: function() {
    var bodyLayout       = $div({'class': 'l-answer-body'});
    var bodyInput        = $input({'class': 'b-answer-body', 'type': 'text', 'name': 'question[answer_attributes][][body]'});
    var answerContainer  = $div({'class': 'b-answer'});
    var answersContainer = $$('.b-answers-column').first();

    bodyLayout.insert({bottom: bodyInput});
    answerContainer.insert({bottom: $a({'class': 'b-remove-answer-link'})});
    answerContainer.insert({bottom: bodyLayout});
    answersContainer.insert({bottom: answerContainer});

    this.addAnswer(new QuestionForm.Answer(answerContainer));
  }
});

QuestionForm.Behavior = Behavior.create({
  initialize: function() {
    new QuestionForm(this.element);
  }
});

QuestionForm.AddButtons = {};
QuestionForm.AddButtons.Behavior = Behavior.create({
  answer: null,

  initialize: function(form) {
    this.form = form;
  },

  onclick: function(event) {
    this.form.buildAnswer();
  }
});

QuestionForm.RemoveButton = {};
QuestionForm.RemoveButton.Behavior = Behavior.create({
  answer: null,

  initialize: function(answer) {
    this.answer = answer;
  },

  onclick: function(event) {
    this.answer.remove();
  }
});

QuestionForm.Question = Class.create();

QuestionForm.Answer = Class.create({
  container: null, id: null, body: null,

  initialize: function(element) {
    this.container = element;
    this.attachEvents();
  },

  isNewRecord: function() {
    return this.id === null;
  },

  detectPossibleAttributes: function(input) {
    return this.detectId(input) || this.detectBody(input);
  },

  detectId: function(input) {
    this.detectAttribute(input, 'id');
  },

  detectBody: function(input) {
    this.detectAttribute(input, 'body');
  },

  detectAttribute: function(input, attributeName) {
    if (input.hasClassName('b-answer-' + attributeName)){
      this[attributeName] = input.getValue();
    }
  },

  remove: function() {
    if (this.isNewRecord()) {
      this.container.remove();
    } else {
      this.container.insert($input({'type': 'hidden','name': 'question[answer_attributes][' + this.id + '][should_remove]', 'value': 1}));
      this.container.hide();
    }
  },

  attachEvents: function() {
    Event.addBehavior({
      '.b-remove-answer-link': QuestionForm.RemoveButton.Behavior(this)
    });
  }
});

Event.addBehavior({
  '.b-question-form': QuestionForm.Behavior()
});
