window.onload = ->
  enchant()

  game = new Core(320, 320)
  game.fps = 30

  ButtonLabel = Class.create(Label, {
    initialize: (n)->
      Label.call(this, 32, 32)
      this.x = 8
      this.y = 8
      this.color = "#cccccc"
      this.text = n
  })

  ButtonSprite = Class.create(Sprite, {
    initialize: (n)->
      Sprite.call(this, 32, 32)
      this.x = 0
      this.y = 0
      this.backgroundColor = "#000000"
  })

  Button = Class.create(Group, {
    initialize: (n)->
      x = (n - 1) % 5
      y = parseInt((n - 1) / 5, 10)

      Group.call(this, 32, 32)
      this.x = x * 36 + 4
      this.y = y * 36 + 4
      this.addChild(new ButtonSprite(n))
      this.addChild(new ButtonLabel(n))
      game.rootScene.addChild(this)
  })


  game.onload = ->
    for i in [1..25]
      new Button(i)

  game.start()