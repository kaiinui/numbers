window.onload = ->
  enchant()

  game = new Core(320, 320)
  game.fps = 30

  Button = Class.create(Sprite, {
    initialize: ->
      Sprite.call(this, 32, 32)
      this.backgroundColor = "#000000"
      this.x = 0
      this.y = 0
      game.rootScene.addChild this
  })

  game.onload = ->
    button = new Button()

    game.rootScene.addChild button

  game.start()