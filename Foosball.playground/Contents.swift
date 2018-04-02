//: A UIKit based Playground for presenting user interface

import UIKit
import PlaygroundSupport
import SpriteKit

// Deal with starting the game.


// MARK: Control the view.
let skView = SKView(frame: CGRect(x: 0, y: 0, width: 320, height: 480))

class GameScene: SKScene {

    // : Introduction
    // Represent each of the quadrants that can be touched.
    var topRightQuad = CGRect(x: skView.frame.width * 0.5, y: skView.frame.height * 0.25, width: skView.frame.width * 0.5, height: skView.frame.height * 0.25)
    var bottomRightQuad = CGRect(x: skView.frame.width * 0.5, y: 0, width: skView.frame.width * 0.5, height: skView.frame.height * 0.25)
    var topLeftQuad = CGRect(x: 0, y: skView.frame.height * 0.25, width: skView.frame.width * 0.5, height: skView.frame.height * 0.25)
    var bottomLeftQuad = CGRect(x: 0, y: 0, width: skView.frame.width * 0.5, height: skView.frame.height * 0.25)

    // Variables to know when finger is continuously on screen.
    var touchTopRight = false
    var touchTopLeft = false
    var touchBotLeft = false
    var touchBotRight = false

    // Variables to know when a score has occured.
    var scoreTop = false
    var scoreBot = false

    // Hold the running player's score.
    var score = 0

    // Hold the opponent's running score.
    var oppScore = 0

    override init(size: CGSize) {

        super.init(size: size)

        // Make the top bar of the player.
        let topPlayBar = SKShapeNode(rectOf: CGSize(width: 320, height: 3))
        topPlayBar.position = CGPoint(x: self.size.width * 0.5, y: self.size.height * 0.375)
        topPlayBar.fillColor = .red
        topPlayBar.strokeColor = .red
        self.addChild(topPlayBar)

        // Make the bot bar of the player.
        let botPlayBar = SKShapeNode(rectOf: CGSize(width: 320, height: 3))
        botPlayBar.position = CGPoint(x: self.size.width * 0.5, y: self.size.height * 0.125)
        botPlayBar.fillColor = .red
        botPlayBar.strokeColor = .red
        self.addChild(botPlayBar)

        // Make the top bar of the enemy.
        let topEnemyBar = SKShapeNode(rectOf: CGSize(width: 320, height: 3))
        topEnemyBar.position = CGPoint(x: self.size.width * 0.5, y: self.size.height * 0.625)
        topEnemyBar.fillColor = .blue
        topEnemyBar.strokeColor = .blue
        self.addChild(topEnemyBar)

        // Make the bot bar of the enemy.
        let botEnemyBar = SKShapeNode(rectOf: CGSize(width: 320, height: 3))
        botEnemyBar.position = CGPoint(x: self.size.width * 0.5, y: self.size.height * 0.875)
        botEnemyBar.fillColor = .blue
        botEnemyBar.strokeColor = .blue
        self.addChild(botEnemyBar)

        // Come back to configure the music and background here.
        let backgroundImage = SKSpriteNode(imageNamed: "foosballfield")
        backgroundImage.position = CGPoint(x: self.frame.size.width / 2, y: self.frame.size.height / 2)
        self.addChild(backgroundImage)


        // Configure the player's score.
        var scoreLabel: SKLabelNode!
        scoreLabel = SKLabelNode(fontNamed: "Helvetica New")
        scoreLabel.fontColor = .white
        scoreLabel.text = "Player Score: 0"
        scoreLabel.fontSize = 12
        scoreLabel.name = "score"
        scoreLabel.horizontalAlignmentMode = .left
        scoreLabel.position = CGPoint(x: self.frame.width * 0.04, y: self.frame.height * 0.0025)
        self.addChild(scoreLabel)

        // Configure the opponent's score.
        var oppScoreLabel: SKLabelNode!
        oppScoreLabel = SKLabelNode(fontNamed: "Helvetica New")
        oppScoreLabel.fontColor = .white
        oppScoreLabel.text = "Enemy Score: 0"
        oppScoreLabel.fontSize = 12
        oppScoreLabel.name = "oppScore"
        oppScoreLabel.horizontalAlignmentMode = .right
        oppScoreLabel.position = CGPoint(x: self.frame.width * 0.97, y: self.frame.height * 0.975)
        self.addChild(oppScoreLabel)

        // Disable gravity across the board.
        self.physicsWorld.gravity = CGVector(dx: 0, dy: 0)

        // Add a table border so that the ball does not dissapear off the side.
        let tableBorder = SKPhysicsBody(edgeLoopFrom: self.frame)

        self.physicsBody = tableBorder
        self.physicsBody?.friction = 0

        // Make a game ball.
        let ball = SKShapeNode(circleOfRadius: 10)
        ball.fillColor = SKColor.white
        ball.fillTexture = SKTexture(imageNamed: "soccerball.png")
        ball.position = CGPoint(x: self.size.width * 0.5, y: self.size.height * 0.5)
        ball.name = "ball"

        // Add the ball to the screen.
        self.addChild(ball)

        // Deal with the physics of the ball.
        ball.physicsBody = SKPhysicsBody(circleOfRadius: ball.frame.size.width / 2)
        ball.physicsBody?.restitution = 1
        ball.physicsBody?.linearDamping = 0
        ball.physicsBody?.allowsRotation = false

        // Get the ball moving.
        ball.physicsBody?.applyImpulse(CGVector(dx: 4, dy: -4))

        // Make each of the players.
        let topLeftPlay = Player(image: "redPlayer", name: "topLeftPlay", xPosition: self.size.width * 0.25, yPosition: self.size.height * 0.375)
        let topRightPlay = Player(image: "redPlayer", name: "topRightPlay", xPosition: self.size.width * 0.75, yPosition: self.size.height * 0.375)
        let botPlay = Player(image: "redPlayer", name: "botPlay", xPosition: self.size.width * 0.5, yPosition: self.size.height * 0.125)

        // Add the players to the screen.
        self.addChild(topLeftPlay)
        self.addChild(topRightPlay)
        self.addChild(botPlay)

        // Make each of the enemies
        let topLeftEnemy = Player(image: "blueOpponent", name: "topLeftEnemy", xPosition: self.size.width * 0.25, yPosition: self.size.height * 0.625)
        let topRightEnemy = Player(image: "blueOpponent", name: "topRightEnemy", xPosition: self.size.width * 0.75, yPosition: self.size.height * 0.625)
        let botEnemy = Player(image: "blueOpponent", name: "botEnemy", xPosition: self.size.width * 0.5, yPosition: self.size.height * 0.875)

        // Add each of the enemies to the screen.
        self.addChild(topLeftEnemy)
        self.addChild(topRightEnemy)
        self.addChild(botEnemy)

        // Meant to be transparent to represent the area which alligns with the background.
        let topGoal = Goal(image: "goal.png", xPosition: self.size.width * 0.5, yPosition: self.size.height, title: "topGoal")
        let botGoal = Goal(image: "goal.png", xPosition: self.size.width * 0.5, yPosition: -2, title: "botGoal")

        // Make the goals transparent.
        topGoal.alpha = 1
        botGoal.alpha = 1

        // Add the goals to the screen.
        self.addChild(topGoal)
        self.addChild(botGoal)

    }

    // Add score every time the ball is put into a goal. Updates score labels.
    func addScore(scoreLabel: SKLabelNode, isEnemy: Bool) {
        score += 1
        if (isEnemy) {
            scoreLabel.text = "Enemy Score: \(score)"
        } else {
            scoreLabel.text = "Player Score: \(score)"
        }
    }

    required init?(coder aDecorder: NSCoder) {
        super.init(coder: aDecorder)
    }

    // Tells object that a touch has been inputted to the view.
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first // as UITouch = (already knows).
        let touchLocation = touch?.location(in: self)


        if (topRightQuad.contains(touchLocation!)) {
            touchTopRight = true
        }

        if (topLeftQuad.contains(touchLocation!)) {
            touchTopLeft = true
        }

        if (bottomRightQuad.contains(touchLocation!)) {
            touchBotRight = true
        }

        if (bottomLeftQuad.contains(touchLocation!)) {
            touchBotLeft = true
        }
    }

    // Reset the position of the ball to play another round. Also, add movement.
    func resetBall() {
        let ball = self.childNode(withName: "ball") as! SKShapeNode
        ball.position.x = skView.frame.width * 0.5
        ball.position.y = skView.frame.height * 0.5
        ball.physicsBody?.applyImpulse(CGVector(dx: 5, dy: -5))
    }

    override func update(_ currentTime: TimeInterval) {

        // Search and assign references for each of the player nodes.
        let topLeftPlay = self.childNode(withName: "topLeftPlay") as! Player
        let topRightPlay = self.childNode(withName: "topRightPlay") as! Player
        let botPlay = self.childNode(withName: "botPlay") as! Player

        // Search and assign references for each of the opponent nodes.
        let topLeftEnemy = self.childNode(withName: "topLeftEnemy") as! Player
        let topRightEnemy = self.childNode(withName: "topRightEnemy") as! Player
        let botEnemy = self.childNode(withName: "botEnemy") as! Player

        // Search and assign reference for the ball.
        let ball = self.childNode(withName: "ball") as! SKShapeNode

        // Search and assign references for the scores.
        let score = self.childNode(withName: "score") as! SKLabelNode
        let oppScore = self.childNode(withName: "oppScore") as! SKLabelNode

        // Search and assign references for each of the goals.
        let topGoal = self.childNode(withName: "topGoal") as! Goal
        let botGoal = self.childNode(withName: "botGoal") as! Goal

        // If a specific quadrant is touched, then move the player in that direciton, and the enemy in a random response.

        if (touchTopRight) {
            if (topRightPlay.willBeInBoundsRight(currNode: topRightPlay)) {
                topRightPlay.position.x += 20
                topLeftPlay.position.x += 20
                if (topRightEnemy.willBeInBoundsRight(currNode: topRightEnemy)) {
                    let randMovement = arc4random_uniform(20)
                    topRightEnemy.position.x += CGFloat(randMovement)
                    topLeftEnemy.position.x += CGFloat(randMovement)
                }
            }
        }
        if (touchTopLeft) {
            if (topLeftPlay.willBeInBoundsLeft(currNode: topLeftPlay)) {
                topLeftPlay.position.x -= 20
                topRightPlay.position.x -= 20
                if (topLeftEnemy.willBeInBoundsLeft(currNode: topLeftEnemy)) {
                    let randMovement = arc4random_uniform(20)
                    topLeftEnemy.position.x -= CGFloat(randMovement)
                    topRightEnemy.position.x -= CGFloat(randMovement)
                }
            }
        }

        if (touchBotRight) {
            if (botPlay.willBeInBoundsRight(currNode: botPlay)) {
                botPlay.position.x += 20
                if (botEnemy.willBeInBoundsRight(currNode: botEnemy)) {
                    let randMovement = arc4random_uniform(20)
                    botEnemy.position.x += CGFloat(randMovement)
                }
            }
        }
            if (touchBotLeft) {
                if (botPlay.willBeInBoundsLeft(currNode: botPlay)) {
                    botPlay.position.x -= 20
                    if (botEnemy.willBeInBoundsLeft(currNode: botEnemy)) {
                        let randMovement = arc4random_uniform(20)
                        botEnemy.position.x -= CGFloat(randMovement)
                    }
                }
            }

            // Score on the bot goal. Opponent scores.
            if ((ball.position.y < botGoal.position.y + 20) && (ball.position.x > 100 && ball.position.x < 220)) {
                addScore(scoreLabel: oppScore, isEnemy: true)
                resetBall()
            }

            // Score on the top goal. Player scores.
            if ((ball.position.y > topGoal.position.y - 20) && (ball.position.x > 100 && ball.position.x < 220)) {
                addScore(scoreLabel: score, isEnemy: false)
                resetBall()

            }
        }

    // Responder is signalled when fingers are lifted, and the touch input ends.
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first // as UITouch = (already knows).
        let touchLocation = touch?.location(in: self)

        // End the movement once a touch is released.
        if (topRightQuad.contains(touchLocation!)) {
            touchTopRight = false
        }

        if (topLeftQuad.contains(touchLocation!)) {
            touchTopLeft = false
        }

        if (bottomRightQuad.contains(touchLocation!)) {
            touchBotRight = false
        }

        if (bottomLeftQuad.contains(touchLocation!)) {
            touchBotLeft = false
        }
    }
}
class Player: SKSpriteNode {

    /// Make a new SKSpriteNode player with parameters for Foosball.
    init(image: String, name: String, xPosition: CGFloat, yPosition: CGFloat) {
        let texture = SKTexture(imageNamed: image)

        // Reference the super constructor.
        super.init(texture: texture, color: .red, size: CGSize(width: 60, height: 15))
        self.name = name

        // Place at a precise position.
        self.position = CGPoint(x: xPosition, y: yPosition)

        // Set each player's physics.
        self.physicsBody = SKPhysicsBody(rectangleOf: self.frame.size)
        self.physicsBody?.friction = 0.1
        self.physicsBody?.restitution = 0
        self.physicsBody?.isDynamic = false

        // For the time being every player is being made with uniform width and height.
        self.size = CGSize(width: 60, height: 15)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func willBeInBoundsLeft(currNode: SKSpriteNode) -> Bool {
        if (currNode.position.x - 50 > 0) {
            return true
        } else {
            return false
        }
    }

    // Return if the player's position will keep them in bounds after a move.

    func willBeInBoundsRight(currNode: SKSpriteNode) -> Bool {
        if (currNode.position.x < 270) {
            return true
        } else {
            return false
        }
    }

}


class Goal: SKSpriteNode {

    /// Make a new SKSpriteNode goal with parameters for Foosball.
    init(image: String, xPosition: CGFloat, yPosition: CGFloat, title: String) {
        let texture = SKTexture(imageNamed: "goal.png")
        super.init(texture: texture, color: .blue, size: CGSize(width: 120, height: 30))
        self.position = CGPoint(x: xPosition, y: yPosition)
        self.name = title
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

let gameScene = GameScene(size: skView.bounds.size)
//gameScene.scaleMode = .aspectFill

// Done configuring the scene, time to present it to be interacted with.
skView.presentScene(gameScene)

// Present the view controller in the Live View window.
PlaygroundPage.current.liveView = skView

