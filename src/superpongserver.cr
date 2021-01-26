require "kemal"

# Состояние игры
enum GameState
  # Ожидание игроков
  WaitPlayers
  # Состояние игры
  Game
end

# Сетевая сущность
abstract class NetworkEntity
  # Переводит состояние в бинарный поток
  abstract def state_to_io(io : IO, format : IO::ByteFormat)
end

# Шарик которым играют игроки
class Ball < NetworkEntity
  # Скорость шарика по умолчанию
  DEFAULT_SPEED = 20

  # Радиус шарика
  getter radius : Int32
  # Положение шарика по x
  property x : Int32
  # Положение шарика по y
  property y : Int32
  # Скорость по x
  property speedx : Int32
  # Скорость по y
  property speedy : Int32

  def initialize
    @radius = 20
    @x = 0
    @y = 0
    @speedx = DEFAULT_SPEED
    @speedy = DEFAULT_SPEED
  end

  # Двигает шарик
  def move
    @x += @speedx
    @y += @speedy
  end

  # Переводит состояние в бинарный поток
  def state_to_io(io : IO, format : IO::ByteFormat)
    io.write_bytes @radius, format
    io.write_bytes @x, format
    io.write_bytes @y, format
    io.write_bytes @speedx, format
    io.write_bytes @speedy, format
  end
end

# Игрок
class Player
  DEFAULT_WIDTH  = 20
  DEFAULT_HEIGHT = 40

  # Сокет игрока
  getter socket : HTTP::WebSocket

  # Ширина
  getter width : Int32
  # Высота
  getter height : Int32
  # Положение игрока по x
  property x : Int32
  # Положение игрока по y
  property y : Int32
  # Скорость по x
  property speedx : Int32
  # Скорость по y
  property speedy : Int32

  def initialize(@socket)
    @width = DEFAULT_WIDTH
    @height = DEFAULT_HEIGHT
    @x = 0
    @y = 0
    @speedy = 0
    @speedx = 0
  end
end

# Стена
class Wall
  # Высота по умолчанию
  DEFAULT_HEIGHT = 20

  # Высота стены
  getter height : Int32

  def initialize
    @height = DEFAULT_HEIGHT
  end
end

# Игра
class Game
  WIDTH  = 800
  HEIGHT = 600

  # Состояние игры
  @state : GameState
  # Шарик которым играют игроки
  getter ball : Ball
  # Игрок 1
  getter player_one : Player?
  # Игрок 2
  getter player_two : Player?

  # Запускает игру
  private def start_game
    return if @state == GameState::Game

    p "Game started"

    @state = GameState::Game

    @player_one.not_nil!.socket.on_binary do |x|
      p x
    end

    # @player_two.not_nil!.socket.on_binary do |x|

    # end

    # Пока состояние игры отсылает состояние игровых объектов
    spawn do
      io = IO::Memory.new

      while @state == GameState::Game
        io.clear

        # Двигает шарик
        @ball.move
        if @ball.x < 0 | @ball.x > WIDTH
          @ball.speedx *= -1
        end

        if @ball.y < 0 | @ball.y > HEIGHT
          @ball.speedy *= -1
        end

        @ball.state_to_io(io, IO::ByteFormat::BigEndian)
        @player_one.not_nil!.socket.send(io.to_slice)

        # Двигает игроков

        # Пауза между расчётами
        sleep 0.5
      end
    end
  end

  def initialize
    @started = false
    @state = GameState::WaitPlayers
    @ball = Ball.new
  end

  # Обрабатывает новое подключение от игрока
  def process_new_connection(socket : HTTP::WebSocket)
    # TODO: разные комнаты

    p "New connection"

    if @player_one.nil?
      @player_one = Player.new(socket)
    elsif @player_two.nil?
      @player_two = Player.new(socket)
    end

    # Запускает игру
    # if @player_one && @player_two
    if @player_one
      start_game
    end
  end
end

game = Game.new

get "/" do |env|
  send_file env, "./bin/html5/bin/index.html"
end

ws "/ws" do |socket|
  game.process_new_connection(socket)
end

public_folder "./bin/html5/bin"

port = (ENV["PORT"]? || 8080).to_i
Kemal.run port
