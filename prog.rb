#task manager
#
#operations:
# + show tasks
# + input task
# + edit task
# + delete task
# + save tasks to file
# + load tasks from file
# + mode & error messages
# - change task's status

class Tasks

  def initialize
    @tarr = Array.new
    @mes = { :add     => "add task mode",
             :edit    => "edit task mode",
             :delete  => "delete task mode",
             :quit    => "save & quit"
            }
    @status = "planned"
  end

  def tamount
    @tarr.length
  end

  def mode_message(message)
    puts "\n" + message
  end

  def error_message(code = @command)
    puts "\n" + code + " not available"
  end

  def length_of_longest_string
    if tamount != 0
      @length = @tarr.max_by(&:length).length
    else
      @length = 10
    end
    return @length
  end

  def header
    if tamount != 0
      l = length_of_longest_string
      puts "N".ljust(3) + "Task".ljust(l) + "  " + "Status".ljust(10)
    end
  end

  def show_tasks
    l = length_of_longest_string
    puts "\n"
    header
    i = 0
    @tarr.each do |x|
      puts i.to_s.ljust(3) + x.ljust(l) + "  " + @status.ljust(10)
      i += 1
    end
    puts "Tasks' amount: " + tamount.to_s
  end

  def show_menu
    print "(a)dd "
    if tamount != 0
      print "(e)dit "
      print "(s)tatus "
      print "(d)elete "
    end
    puts "(q)uit"
  end

  def select_command
    print "Command: "
    @command = gets.chomp
    case @command
      when "a"
        mode_message(@mes[:add])
        show_tasks
        add_task_to_array
      when "e"
        if tamount != 0
          mode_message(@mes[:edit])
          show_tasks
          edit_task
        else
          error_message()
        end
      when "s"
        if tamount != 0
          mode_message(@mes[:status])
          show_tasks
          change_status
        else
          error_message()
        end
      when "d"
        if tamount != 0
          mode_message(@mes[:delete])
          show_tasks
          delete_task_from_array
        else
          error_message()
        end
      when "q"
        save_tasks_to_file
        mode_message(@mes[:quit])
        abort
      else
        error_message()
    end
  end

  def add_task_to_array
    print "New task: "

    @task = gets.chomp
    if @task != ""
      @tarr << @task
    end

  end

  def edit_task
    print "Task number: "
    @tnum = gets.chomp.to_i
    if @tnum >= 0 && @tnum <= tamount
      puts "Old redaction: " + @tarr[@tnum].to_s
      print "New redaction: "

      @new_red = gets.chomp
        if @new_red != ""
          @tarr[@tnum] = @new_red
        end

    else
      error_message(@tnum.to_s)
    end
  end

  def delete_task_from_array
    print "Task number: "
    @tnum = gets.chomp.to_i
    if @tnum >= 0 && @tnum <= tamount
      @tarr.delete_at(@tnum)
    else
      error_message(@tnum.to_s)
      return
    end
  end

  def load_tasks_from_file
    i = 0
    File.open("tasks.txt").each do |line|
      @tarr[i] = line.chomp
      i += 1
    end
  end

  def save_tasks_to_file
    File.open("tasks.txt", 'w') do |file|
      file.puts(@tarr.each {|x|})
    end
  end

end
