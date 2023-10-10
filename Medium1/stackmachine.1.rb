class MiniLangError < StandardError
end

class InvalidToken < MiniLangError
end

class NoPrint < MiniLangError
end

class EmptyStackError < MiniLangError
end

class Minilang
  ACTIONS = %w(PUSH ADD SUB MULT DIV MOD POP PRINT)
  attr_accessor :commands, :register, :stack

  def initialize(command_string)
    @register = 0
    @stack = []
    @commands = command_string
  end

  def eval
    commands.split.each { |command| eval_tokens(command) }
  rescue MiniLangError => e
    puts e.message
  end

  def eval_tokens(command)
    if command.to_i.to_s == command
      self.register = command.to_i
    elsif ACTIONS.include?(command)
      send(command.downcase)
    else
      raise InvalidToken, "Invalid token: #{command}"
    end
  end

  def push
    stack.push(register)
  end

  def add
    self.register += stack.pop
  end

  def sub
    self.register -= stack.pop
  end

  def mult
    self.register *= stack.pop
  end

  def div
    self.register /= stack.pop
  end

  def mod
    self.register %= stack.pop
  end

  def pop
    if stack.last == nil
      raise EmptyStackError, "Empty stack!"
    else
      self.register = stack.pop
    end
  end

  def print
    p register
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