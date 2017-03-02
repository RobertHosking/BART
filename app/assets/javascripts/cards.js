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

$("#dataset-select").change( function(){
    $("#card-form").append(loading);
  $.post('/get_columns.json', { dataset_id: $(this).val() },
    function(data){
      buildColumnsSelect(data);
    });
    loading.remove();

});

function buildColumnsSelect(columns){
  var l = $("<label for='column'>Use</label>");
  var s = $("<select id='column-select' name='column' class='form-control'/>");
  var d = $("<input type='checkbox' id='select-where-checkbox' value='select-where'> <label for='select-where-checkbox'>Where</label>")
  jQuery.each(columns, function(index, val){
    $("<option />", {value: val, text: val}).appendTo(s);
  });
  if ($("#column-select").length){
    $("#column-select").replaceWith(s);
  } else {
  $("#card-form").append('<br>');
  $("#card-form").append(l);
  $("#card-form").append(s);
  $("#card-form").append(d);

  }

  $('#select-where-checkbox').change(function() {

    var a = $("<select id='column-where' name='column-where' class='form-control'/>");
    var c = $("<label id='column-equals-label' for='column-where'>Equals</label>");
    var b = $("<select id='column-equals' name='column-equals' class='form-control'/>");
        if($('#select-where-checkbox').is(":checked")) {
            jQuery.each(columns, function(index, val){
              $("<option />", {value: val, text: val}).appendTo(a);
            });
            $("#card-form").append(a);
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
            $("#card-form").append(c);
            $("#card-form").append(b);
        }
        if($('#select-where-checkbox').is(":checked") === false){
          $("#column-where").remove();
          $("#column-equals-label").remove();
          $("#column-equals").remove();
        }
    });
  $("#column-select").change( function(){
    $("#card-form").append(loading);
    $("#actions-select-group").remove();
    $.post('/get_actions', { dataset_id: $("#dataset-select").val(), column_name: $(this).val() },
      function(data){
        if ($("#actions-select").length){
          $("#actions-select-group").replaceWith(data);
        } else {
          $("#card-form").append(data);
        }
        loading.remove();
        $("#actions-select").change( function(){
          $("#card-form").append(loading);
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

function get_random_color() {
  var letters = '0123456789ABCDEF';
  var color = '#'
  
  for (var i=0; i<6; i++) {
    color += letters[Math.floor(Math.random() * 16)];
  }
  
  return color;
}

function change_colors(data){
  var chart_colors = {};
  
  var keys = Object.keys(data);
  
  for(var i=0; i<keys.length; i++){
    chart_colors[keys[i]] = get_random_color();
  }
  
  return chart_colors
}

function unique_occurences(data) {
  var cat = [];
  var data_columns = [];
  Object.keys(data).forEach(function(key)
  {
    // cat.push(key);
    data_columns.push([key, data[key]]);
  });
  console.log(data_columns);
  pieChartBottomLegend.load({
    unload: true,
    columns: data_columns
  });
  
  pieChartBottomLegend.data.colors(change_colors(data));
}


// disable the button when a dataset is not selected
// we need to enable the button only when we have all of the information needed to make a card
$("#dataset-select").change( function(){
  if ($(this).val() == 'none'){
    $("#card-submit").prop('disabled', true);
  }
});
