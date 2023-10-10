class InvalidToken < StandardError
end

class NoPrint < StandardError
end

class Minilang
  attr_accessor :commands, :register, :stack

  def initialize(command_string)
    @commands = command_string.split(' ').map do |cmd|
      if cmd.to_i.to_s == cmd
        cmd.to_i
      else
        cmd
      end
    end
    @register = 0
    @stack = []
  end

  def eval
    loop do
      break if commands.empty?
      raise NoPrint, "(nothing printed; no PRINT commands)" if !commands.include?('PRINT')
      command = commands.shift
      if command.is_a? Integer
        n_cmd(command)
      elsif command == 'PUSH'
        push_cmd
      elsif command == 'ADD'
        add_cmd
      elsif command == 'SUB'
        sub_cmd
      elsif command == 'MULT'
        mult_cmd
      elsif command == 'DIV'
        div_cmd
      elsif command == 'MOD'
        mod_cmd
      elsif command == 'POP'
        pop_cmd
      elsif command == 'PRINT'
        print_cmd
      else
        raise InvalidToken, "Invalid Token: #{command}"
      end
    end
  rescue InvalidToken => e
    puts e.message
  rescue NoPrint => e
    puts e.message
  end

  def n_cmd(command)
    self.register = command
  end

  def push_cmd
    stack.push(register)
  end

  def add_cmd
    self.register += stack.pop
  end

  def sub_cmd
    self.register -= stack.pop
  end

  def mult_cmd
    self.register *= stack.pop
  end

  def div_cmd
    self.register = self.register / stack.pop
  end

  def mod_cmd
    self.register = self.register % stack.pop
  end

  def pop_cmd
    self.register = stack.pop
  end

  def print_cmd
    if register == nil
      p "Empty stack!"
    else
      p register
    end
  end
end

Minilang.new('PRINT').eval
# 0

Minilang.new('5 PUSH 3 MULT PRINT').eval
# 15

Minilang.new('5 PRINT PUSH 3 PRINT ADD PRINT').eval
# 5
# 3
# 8

Minilang.new('5 PUSH 10 PRINT POP PRINT').eval
# 10
# 5

Minilang.new('5 PUSH POP POP PRINT').eval
# Empty stack!

Minilang.new('3 PUSH PUSH 7 DIV MULT PRINT ').eval
# 6

Minilang.new('4 PUSH PUSH 7 MOD MULT PRINT ').eval
# 12

Minilang.new('-3 PUSH 5 XSUB PRINT').eval
# Invalid token: XSUB

Minilang.new('-3 PUSH 5 SUB PRINT').eval
# 8

Minilang.new('6 PUSH').eval
# (nothing printed; no PRINT commands)