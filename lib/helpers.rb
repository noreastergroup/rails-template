def yes_or_no(question)
  ask(question, %i[blue bold], default: 'Y', limited_to: %w[Y n]) == 'Y'
end

def print_step(step)
  width = 60
  side_border = "##"
  step_text = " #{step} "
  padding = width - step_text.size - 4
  left_pad = " " * (padding / 2)
  right_pad = " " * (padding - padding / 2)
  border_line = "\e[1;36m" + "#" * width + "\e[0m"
  mid_line = "\e[1;36m#{side_border}\e[0m#{left_pad}\e[1;33m#{step.upcase.center(step_text.size)}\e[0m#{right_pad}\e[1;36m#{side_border}\e[0m"
  puts border_line
  puts mid_line
  puts border_line
end

def create_file_from_resource(target_path, resource_path)
  create_file target_path, File.read(File.join(__dir__, '..', 'resources', resource_path))
end
