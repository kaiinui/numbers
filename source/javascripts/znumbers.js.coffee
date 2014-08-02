window.onload = ->
  enchant()

  game = new Core(320, 320)
  game.fps = 30
  game._n = 1

  ButtonLabel = Class.create(Label, {
    initialize: (number)->
      Label.call(this, 32, 32)
      this.x = 8
      this.y = 8
      this.color = "#cccccc"
      this.text = number
  })

  ButtonSprite = Class.create(Sprite, {
    initialize: ->
      Sprite.call(this, 32, 32)
      this.x = 0
      this.y = 0
      this.backgroundColor = "#000000"
  })

  Button = Class.create(Group, {
    initialize: (n, number)->
      x = (n - 1) % 5
      y = parseInt((n - 1) / 5, 10)

      Group.call(this, 32, 32)
      this.x = x * 36 + 4
      this.y = y * 36 + 4
      this._n = number
      this.addChild(new ButtonSprite())
      this.addChild(new ButtonLabel(number))
      game.rootScene.addChild(this)

    ontouchstart: ->
      if(game._n is this._n)
        this.remove()
        game._n += 1
  })


  game.onload = ->
    a = []
    for i in [1..25]
      a.push(i)
    shuffled = _.shuffle(a)

    for i in [1..25]
      new Button(i, shuffled[i - 1]) # [REFACTOR]

  game.start()