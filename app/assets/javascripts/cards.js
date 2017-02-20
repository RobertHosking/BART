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
  var l = $("<label for='column'>Target</label>");
  var s = $("<select id='column-select' name='column' class='form-control'/>");
  jQuery.each(columns, function(index, val){
    $("<option />", {value: val, text: val}).appendTo(s);
  });
  if ($("#column-select").length){
    $("#column-select").replaceWith(s);
  } else {
  $("#card-form").append('<br>');
  $("#card-form").append(l);
  $("#card-form").append(s);

  }
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
      });
  });
}




// disable the button when a dataset is not selected
// we need to enable the button only when we have all of the information needed to make a card
$("#dataset-select").change( function(){
  if ($(this).val() == 'none'){
    $("#card-submit").prop('disabled', true);
  }
});
