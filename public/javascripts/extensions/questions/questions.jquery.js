(function($) {

  var QuestionReply = $.klass({
    $form: null,

    initialize: function() {
      this.$form = this.element.find('.b-question-reply-form');
      this.element.data('QuestionReply', this);
      this.attachEvents();
    },

    attachEvents: function() {
      this.$form.attach(QuestionReply.Form, this);
    },

    renderChart: function(json) {
      var chart = new QuestionReply.PieChart(this.element, json.data, {
        title: json.title,
        height: this.element.height()
      });
      chart.render();
    }
  });

  QuestionReply.PieChart = $.klass({
    element: null, options: {}, data: [],
    defaults: {
      width:  250,
      height: 250,
      legend: 'none'
    },

    initialize: function($element, data, options) {
      this.element = $element;
      this.options = $.extend(this.defaults, options);
      this.data    = data;
    },

    render: function() {
      this.element.html('');
      var dataTable = new google.visualization.DataTable();
          dataTable.addColumn('string');
          dataTable.addColumn('number');
          dataTable.addRows(this.data);
      var chart = new google.visualization.PieChart(this.element.get(0));

      return chart.draw(dataTable, this.options);
    }
  });

  QuestionReply.Form = $.klass({
    $submit: null, reply: null,

    initialize: function(reply) {
      this.reply   = reply;
      this.$submit = this.element.find('.b-question-reply-submit');
      this.attachEvents();
    },

    submit: function() {
      return !this.isAjaxMode();
    },

    isAjaxMode: function() {
      var isAjax = this.element.attr('ajax');
      return isAjax && isAjax === 'true';
    },

    attachEvents: function() {
      this.$submit.click(this.submitCall.bind(this));
    },

    submitCall: function() {
      if (!this.isAjaxMode()) return true;

      $.post(this.element.attr('action'), this.element.serializeArray(), this.reply.renderChart.bind(this.reply), 'json');
      return false;
    }

  });


  $(function() {
    $('.l-question-reply-form').attach(QuestionReply);
  });

})(jQuery);