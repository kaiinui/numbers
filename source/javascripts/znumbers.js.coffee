window.onload = ->
  enchant()

  game = new Core(320, 320)
  game.fps = 30

  Button = Class.create(Sprite, {
    initialize: (n)->
      Sprite.call(this, 32, 32)
      this.backgroundColor = "#000000"
      this.x = (n - 1) * 34
      this.y = 0
      game.rootScene.addChild this
      console.log n
  })

  game.onload = ->
    for i in [1..25]
      button = new Button(i)

  game.start()