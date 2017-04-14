


// functions

/**
 * adds and element to another element
 * @param {string} id - the id of the element being added
 * @param {jquery.Object} object - the object being added
 * @param {jqeury.Object} target - where the object is being added to
 **/
function add_element(id, object, target){
  target = target || $("#card-form");
  if ($("#"+id+"-div").length){
    $("#"+id+"-div").replaceWith(object);
  } else {
    target.append('<br>');
    target.append(object);
  }
}

var getUrlParameter = function getUrlParameter(sParam) {
    var sPageURL = decodeURIComponent(window.location.search.substring(1)),
        sURLVariables = sPageURL.split('&'),
        sParameterName,
        i;

    for (i = 0; i < sURLVariables.length; i++) {
        sParameterName = sURLVariables[i].split('=');

        if (sParameterName[0] === sParam) {
            return sParameterName[1] === undefined ? true : sParameterName[1];
        }
    }
};

/**
 * Builds a select complete with id, name and label
 * @param {string} id - id of select
 * @param {string} name - name of select
 * @param {string} label - label text
 * @param {option} options - the options of the select
 * @returns {div} div element containing select and label
 **/
function build_select(id, name, label, options) {
  var select_div = $("<div id='"+id+"-div'>");
  var label = $("<label for='"+name+"'>" +label+"</label>");
  var select = $("<select id='"+id+"' name='card["+name+"]' class='form-control'/>");
  jQuery.each(options, function(index, val){
      $("<option />", {value: val, text: val}).appendTo(select);
  });
  label.appendTo(select_div);
  select.appendTo(select_div);
  return select_div
}

function change_colors(bar, color) {
  bar.data.colors(color);
}

function load_data_bar(bar, data_columns) {
  console.log(bar, data_columns);
    bar.load({
    unload: true,
    columns: data_columns
  });
}



/**
 * Gets what is written in the title field
 * and writes it into the card
 **/
function render_text(){
    var title = $('#title-field').val();
    $('.card-title').text(title);
}

function show_card(){
    var val = $('#card-data-type-select').val();
    $('.card-preview').hide();
    $("#"+val).show();
  }


function unique_occurences(data) {
  load_data_bar(verticalBarChart, format_data_bar(data));
  load_data_bar(pieChartBottomLegend, format_data_pie_donut(data));
  load_data_bar(utilizationDonutChart, format_data_pie_donut(data));
  change_colors(pieChartBottomLegend, get_colors_object(data));
  change_colors(utilizationDonutChart, get_colors_object(data));
  change_colors(verticalBarChart, get_colors_object(data));
  //verticalBarChart.data.colors(change_colors(data));
}

// AJAX calls

function getColumns (data) {
  var url = "/get_columns.json";
    return $.ajax({
        cache:      false,
        url:        url,
        dataType:   "json",
        type:       "post",
        data:       data
    });
}

function getActions(data) {
  var url = "/get_actions"
  return $.ajax({
        cache:      false,
        url:        url,
        dataType:   "json",
        type:       "post",
        data:       data
    });
}

function doAction(data){
  var url = "/do-action" // this is a different pattern to the url it can be confusing.
  return $.ajax({
        cache:      false,
        url:        url,
        dataType:   "json",
        type:       "post",
        data:       data
    });
}

function getPreview(){
  var url = "/cards/text/preview" // this is a different pattern to the url it can be confusing.
  return $.ajax({
        cache:      false,
        url:        url,
        type:       "post",
        data:       {html: $(".ql-editor").html()}
    });
}


$(".ql-preview").click(function(){
  console.log("Click");
  getPreview().done(
    function(html){
      console.log(html);
      $("#previewModal").remove();
      $('body').append(html);
     $("#previewModal").modal('show');
    }).fail(function(jobj, status, server_error) {
    alert( "server error", server_error );
  })
});

$('#card-form').on(
  'change',
  '#select-where-checkbox', function() {
    console.log($("#dataset-select").val())
  getColumns(
    {dataset_id: $("#dataset-select").val()})
    .done(
      function(columns){
        var where_column = build_select("column-where", "where_column", "Where", columns);
        add_element("column-where", where_column, $("#column-select-div"));
    })
  })

  $('#card-form').on(
    'change',
    '#column-where', function() {
      console.log($("#dataset-select").val());
    doAction(
      {
        dataset_id: $("#dataset-select").val(),
        column_name: $("#column-where").val(),
        operation: "values"
    })
      .done(
        function(values){
          var equals_column = build_select("column-equals", "where_equals", "Equals", values);
          add_element("column-equals", equals_column, $("#column-select-div"));
      });
    });



// BUILD COLUMN SELECT
function buildColumnsSelect(columns){
  var form = $("#card-form");

  var column_select = build_select("column-select", "column", "Use", columns);
  var d = $("<input type='checkbox' id='select-where-checkbox' value='select-where'> <label for='select-where-checkbox'>Where</label>");
  add_element("column-select", column_select );
  form.append(d);


}
$('#card-form').on('change', '#actions-select', function(){
  doAction({
    dataset_id: $('#dataset-select').val(),
    column_name: $('#column-select').val(),
    operation: $('#actions-select').val()
  }).done(function(action_result) {
    console.log(action_result)
    unique_occurences(action_result); // this could be a switch statement
    $("#card-submit").prop('disabled', false);
  })
})

// the way to attach an event to an element that doesn't exists yet
$('#card-form').on('change', '#column-select', function() {
  getActions(
    {
      dataset_id: $("#dataset-select").val(),
      column_name: $('#column-select').val()
    }).done(function(actions) {
      var actions_select = build_select("actions-select", "action", "Action", actions);
      add_element("actions-select", actions_select );
    })

});


// Story

// in the beginning there was only a static form showing title, card type, access level, and datasource
// there were also some charts

// this makes the width of the card
function setCardWidth(){
  $( ".card-preview" ).each(function( index ) {
      var $to_fixed = $( this );

      $to_fixed.width( $to_fixed.width() );
    });
}

setCardWidth();

function triggerResize(){
  window.dispatchEvent(new Event('resize'));
}

$("#section-id").val(getUrlParameter('section'));

// he saw that he could not have all of the charts show at the same time so he hid all but one
$('.card-preview').hide(); //hide all templates
show_card(); // show the one currently selected

// he created quantum tunneling to bind the events of the title to the card
$("#card-data-type-select").change(show_card).change(triggerResize).change(render_text); //when select changed
$("#title-field").keyup(render_text);


// when the dataset changes the
$("#dataset-select").change( function(){
  // remove "Where" checkbox and label if it already exists
  $("#column-select-div + br").remove(); // remove the <br> before the checkbox
  $("#select-where-checkbox").remove();
  $("#where-label").remove();
  // add the "Where" box
  //$("#card-form").append(loading);
  getColumns({ dataset_id: $(this).val() }).done(
    function(data){
      var d = $("<input type='checkbox' id='select-where-checkbox' value='select-where'> <label id='where-label' for='select-where-checkbox'>Where</label>");
      var column_select = build_select("column-select", "column", "Use", data);
      add_element("column-select", column_select );
      add_element("checkbox", d);
    });
    //loading.remove();

});


// disable the button when a dataset is not selected
// we need to enable the button only when we have all of the information needed to make a card
$("#dataset-select").change( function(){
  if ($(this).val() == 'none'){
    $("#card-submit").prop('disabled', true);
  }
});
