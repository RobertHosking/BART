module Editor
  def self.text_parse(html)
    vars_to_replace = self.get_vars(html, '~~')
    result_text = html
    puts "result",result_text
    vars_to_replace.each do |variable|
      result = self.do_math(variable)
      result_text = replace_var(result_text, "~~%s~~" % [variable], result)
    end
    return result_text
  end

  def self.do_math(var)
    dataset_id,column,action = var.split("/")
    return self.evaluate(dataset_id,column, action)
  end

  def self.evaluate(dataset_id, column, action) # var = "/dataset/column/action"
    dataset = Dataset.find(dataset_id)
      if action == 'sum'
        result = dataset.sum(dataset.select(column))
      elsif action == 'average'
        result = dataset.average(dataset.select(column))
      elsif action == 'percent'
        result = dataset.sum(dataset.select(column))
      elsif action == 'count'
        result = dataset.count(dataset.select(column))
      elsif action == 'length'
        result = dataset.list_length(dataset.select(column)).to_s
      end
      return result
  end

  def self.replace_var(content, original_var, new_var)
    return content.gsub(original_var, new_var)
  end

  def self.get_vars(content, delimiter)
    content_variables = []
    if content.count(delimiter).odd?
      raise "Unexpected #{delimiter} in text content"
    end
    text = content
    while text.include? delimiter
      con_var =  text[/#{delimiter}(.*?)#{delimiter}/m, 1]
      content_variables << con_var
      text = text.split(delimiter+con_var+delimiter).join(" ")
    end
    return content_variables
  end
end
