window.onload = ->
  enchant()

  game = new Core(320, 320)
  game.fps = 30

  Button = Class.create(Sprite, {
    initialize: (n)->
      x = (n - 1) % 5
      y = parseInt((n - 1) / 5, 10)

      Sprite.call(this, 32, 32)
      this.backgroundColor = "#000000"
      this.x = x * 36 + 4
      this.y = y * 36 + 4
      game.rootScene.addChild this
  })

  game.onload = ->
    for i in [1..25]
      button = new Button(i)

  game.start()