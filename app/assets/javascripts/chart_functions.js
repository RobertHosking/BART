function get_random_color() {
  var letters = '0123456789ABCDEF';
  var color = '#'
  
  for (var i=0; i<6; i++) {
    color += letters[Math.floor(Math.random() * 16)];
  }
  
  return color;
}

function get_colors_object(data){
  var chart_colors = {};
  
  var keys = Object.keys(data);
  
  for(var i=0; i<keys.length; i++){
    chart_colors[keys[i]] = get_random_color();
  }
  
  return chart_colors
}

function format_data_bar(data) {
    var keys = Object.keys(data);
    var x_axis_categories = ['x'].concat(keys);
    
    var chart_data = [];
    keys.forEach(function(key) {
       chart_data.push(data[key]); 
    }); 
    
    return [x_axis_categories, chart_data];
    
}

function format_data_pie_donut(data) {
    var data_columns = [];
  Object.keys(data).forEach(function(key)
  {
    // cat.push(key);
    data_columns.push([key, data[key]]);
  });
  
  return data_columns;
}
