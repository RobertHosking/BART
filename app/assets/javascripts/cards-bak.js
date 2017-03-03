$( ".card-preview" ).each(function( index ) {
    var $to_fixed = $( this );

    $to_fixed.width( $to_fixed.width() );
  });

  function show_card(){
    var val = $('#card-data-type-select').val();
    $('.card-preview').hide();
    $("#"+val).show();
  }

  function render_text(){
    var title = $('#title-field').val();
    $('.card-title').text(title);
  }

  $('.card-preview').hide(); //hide all templates
  show_card(); // show the one currently selected
  $("#card-data-type-select").change(show_card).change(render_text); //when select changed
  $("#title-field").keyup(render_text);


//SEND TO ANOTHER FILE

var loading = $('<br><img width="50px" src="/loading.svg" class="center-block">');
// DATASET CHANGE
$("#dataset-select").change( function(){
    $("#card-form").append(loading);
  $.post('/get_columns.json', { dataset_id: $(this).val() },
    function(data){
      buildColumnsSelect(data);
    });
    loading.remove();

});
// BUILD COLUMN SELECT
function buildColumnsSelect(columns){
  var form = $("#card-form");
  var l = $("<label for='column'>Use</label>");
  var s = $("<select id='column-select' name='column' class='form-control'/>");
  var d = $("<input type='checkbox' id='select-where-checkbox' value='select-where'> <label for='select-where-checkbox'>Where</label>")
  jQuery.each(columns, function(index, val){
    $("<option />", {value: val, text: val}).appendTo(s);
  });
  if ($("#column-select").length){
    $("#column-select").replaceWith(s);
  } else {
  form.append('<br>');
  form.append(l);
  form.append(s);
  form.append(d);
  }
  // WHERE BOX CHANGE
  var where_box = $('#select-where-checkbox');
  where_box.change(function() {
    var a = $("<select id='column-where' name='column-where' class='form-control'/>");
    var c = $("<label id='column-equals-label' for='column-where'>Equals</label>");
    var b = $("<select id='column-equals' name='column-equals' class='form-control'/>");
    var actions = $("#actions-select-group")
        if(where_box.is(":checked")) {
            actions.remove();
            jQuery.each(columns, function(index, val){
              $("<option />", {value: val, text: val}).appendTo(a);
            });
            form.append(a);
            a.change(function(){
              $.post('/do-action', {
                dataset_id: $("#dataset-select").val(),
                column_name: a.val(),
                operation: "count"
              }, function(data){
                Object.keys(data).forEach(function(key)
                {
                  $("<option />", {value: key, text: key}).appendTo(b);
                });
              });
            });
            form.append(c);
            form.append(b);
            form.append(actions);
        }
        if(where_box.is(":checked") === false){
          $("#column-where").remove();
          $("#column-equals-label").remove();
          $("#column-equals").remove();
        }
    });
    // COLUMN SELECT CHANGE
  $("#column-select").change( function(){
    var actions = $("#actions-select-group")
    form.append(loading);
    actions.remove();
    $.post('/get_actions', { dataset_id: $("#dataset-select").val(), column_name: $(this).val() },
      function(data){
        if ($("#actions-select").length){
          actions.replaceWith(data);
        } else {
          form.append(data);
        }
        loading.remove();
        $("#actions-select").change( function(){
          form.append(loading);
          $.post('/do-action', {
            dataset_id: $("#dataset-select").val(),
            column_name: $("#column-select").val(),
            operation: $("#actions-select").val()
          },
            function(data){
                unique_occurences(data);
          });
          loading.remove();
        });
      });
  });
}

function load_data_bar(bar, data_columns) {
  console.log(bar, data_columns);
    bar.load({
    unload: true,
    columns: data_columns
  });
}

function change_colors(bar, color) {
  bar.data.colors(color);
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

// disable the button when a dataset is not selected
// we need to enable the button only when we have all of the information needed to make a card
$("#dataset-select").change( function(){
  if ($(this).val() == 'none'){
    $("#card-submit").prop('disabled', true);
  }
});
