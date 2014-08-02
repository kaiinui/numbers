window.onload = ->
  enchant()

  game = new Core(320, 320)
  game.fps = 30

  game.onload = ->
    button = new Sprite(32, 32)
    button._backgroundColor = "#000000"
    button.x = 0
    button.y = 0

    game.rootScene.addChild button

  game.start()