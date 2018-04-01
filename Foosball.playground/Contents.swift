//: A UIKit based Playground for presenting user interface

import UIKit
import PlaygroundSupport
import SpriteKit
import AVFoundation

// Deal with starting the game.

// MARK: Control the view.
let skView = SKView(frame: CGRect(x: 0, y: 0, width: 320, height: 480))

class GameScene: SKScene {

    // Represent each of the quadrants that can be touched.
    var topRightQuad = CGRect(x: skView.frame.width * 0.5, y: skView.frame.height * 0.25, width: skView.frame.width * 0.5, height: skView.frame.height * 0.25)
    var bottomRightQuad = CGRect(x: skView.frame.width * 0.5, y: 0, width: skView.frame.width * 0.5, height: skView.frame.height * 0.25)
    var topLeftQuad = CGRect(x: 0, y: skView.frame.height * 0.25, width: skView.frame.width * 0.5, height: skView.frame.height * 0.25)
    var bottomLeftQuad = CGRect(x: 0, y: 0, width: skView.frame.width * 0.5, height: skView.frame.height * 0.25)

    // Represent the regions where the goals can be touched.
    var topGoalRect = CGRect(x: skView.frame.width * 0.3125, y: skView.frame.height - 10, width: 120, height: 10)
    var botGoalRect = CGRect(x: skView.frame.width * 0.3125, y: 0, width: 120, height: 10)

    // Use to play background music while playground is running.
    let backgroundMusicPlayer = AVAudioPlayer()

    // Variables to know when finger is continuously on screen.
    var touchTopRight = false
    var touchTopLeft = false
    var touchBotLeft = false
    var touchBotRight = false

    // Variables to know when a score has occured.
    var scoreTop = false
    var scoreBot = false

    // Hold the running score.
    var score = 0
    
    // Hold the opponent running score.
    var oppScore = 0

    // Variables to check when the ball has crossed the goal.
    var touchTopGoal = false
    var touchBotGoal = false

    override init(size: CGSize) {

        super.init(size: size)

        /**
        // Come back to configure the music and background here.
        let backgroundImage = SkSpriteNode(imageNamed "INSERTIMAGENAME")
        backgroundImage.position = CGPoint(self.frame.size.width / 2, self.frame.size.height / 2)
        self.add("INSERTIMAGENAME")
         */
        
        // Configure the player's score.
        var scoreLabel : SKLabelNode!
        scoreLabel = SKLabelNode(fontNamed: "Helvetica")
        scoreLabel.fontColor = .white
        scoreLabel.text = "Score: 0"
        scoreLabel.fontSize = 15
        scoreLabel.name = "score"
        scoreLabel.horizontalAlignmentMode = .left
        scoreLabel.position = CGPoint(x: self.frame.width * 0.01, y: self.frame.height * 0.01)
        self.addChild(scoreLabel)
        
        // Configure the opponent's score.
        var oppScoreLabel : SKLabelNode!
        oppScoreLabel = SKLabelNode(fontNamed: "Helvetica")
        oppScoreLabel.fontColor = .white
        oppScoreLabel.text = "Score: 0"
        oppScoreLabel.fontSize = 15
        oppScoreLabel.name = "oppScore"
        oppScoreLabel.horizontalAlignmentMode = .right
        oppScoreLabel.position = CGPoint(x: self.frame.width * 0.97, y: self.frame.height * 0.97)
        self.addChild(oppScoreLabel)

        // Disable gravity across the board.
        self.physicsWorld.gravity = CGVector(dx: 0, dy: 0)

        // Add a table border so that the ball does not dissapear off the side.
        let tableBorder = SKPhysicsBody(edgeLoopFrom: self.frame)

        self.physicsBody = tableBorder
        self.physicsBody?.friction = 0

        // Make a test ball.
        let ball = SKShapeNode(circleOfRadius: 10)

        ball.position = CGPoint(x: self.size.width * 0.5, y: self.size.height * 0.1)
        ball.fillColor = SKColor.orange
        ball.name = "ball"

        // Add the ball to the screen.
        self.addChild(ball)

        // Deal with the physics of the ball.
        ball.physicsBody = SKPhysicsBody(circleOfRadius: ball.frame.size.width / 2)
        ball.physicsBody?.restitution = 1
        ball.physicsBody?.linearDamping = 0
        ball.physicsBody?.allowsRotation = false

        // Get the ball moving.
        ball.physicsBody?.applyImpulse(CGVector(dx: 5, dy: -5))

        // Make each of the players.
        let topLeftPlay = Player(image: "noimageyet", name: "topLeftPlay", xPosition: self.size.width * 0.25, yPosition: self.size.height * 0.375)
        let topRightPlay = Player(image: "noimageyet", name: "topRightPlay", xPosition: self.size.width * 0.75, yPosition: self.size.height * 0.375)
        let botPlay = Player(image: "noimageyet", name: "botPlay", xPosition: self.size.width * 0.5, yPosition: self.size.height * 0.125)

        // Add the players to the screen.
        self.addChild(topLeftPlay)
        self.addChild(topRightPlay)
        self.addChild(botPlay)

        // Make each of the enemies
        let topLeftEnemy = Player(image: "noimageyet", name: "topLeftEnemy", xPosition: self.size.width * 0.25, yPosition: self.size.height * 0.625)
        let topRightEnemy = Player(image: "noimageyet", name: "topRightEnemy", xPosition: self.size.width * 0.75, yPosition: self.size.height * 0.625)
        let botEnemy = Player(image: "noimageyet", name: "botEnemy", xPosition: self.size.width * 0.5, yPosition: self.size.height * 0.875)

        // Add each of the enemies to the screen.
        self.addChild(topLeftEnemy)
        self.addChild(topRightEnemy)
        self.addChild(botEnemy)

        // Make the goals on the screen.
        let topGoal = Goal(image: "noimageyet", xPosition: self.size.width * 0.5, yPosition: self.size.height, title: "topGoal")
        let botGoal = Goal(image: "noimageyet", xPosition: self.size.width * 0.50, yPosition: 0, title: "botGoal")

        // Add the goals to the screen.
        self.addChild(topGoal)
        self.addChild(botGoal)


        // Test for each of the four quadrants.
        /**
        var q1 = SKShapeNode(rect: topLeftQuad)
        q1.fillColor = .blue
        self.addChild(q1)
        var q2 = SKShapeNode(rect: topRightQuad)
        q2.fillColor = .green
        self.addChild(q2)
        var q3 = SKShapeNode(rect: bottomLeftQuad)
        q3.fillColor = .red
        self.addChild(q3)
        var q4 = SKShapeNode(rect: bottomRightQuad)
        q4.fillColor = .yellow
        self.addChild(q4)
         */
    }
    
    
    func addScore(scoreLabel : SKLabelNode) {
        score += 1
        scoreLabel.text = "Score: \(score)"
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
        var score = self.childNode(withName: "score") as! SKLabelNode
        var oppScore = self.childNode(withName: "oppScore") as! SKLabelNode
        
        // Search and assign references for each of the goals.
        let topGoal = self.childNode(withName: "topGoal") as! Goal
        let botGoal = self.childNode(withName: "botGoal") as! Goal

        // If a specific quadrant is touched, then move the player in that direciton, and the enemy in a random response.

        if (touchTopRight) {
            if (topRightPlay.inBoundsRight(currPosition: topRightPlay.position.x)) {
                topRightPlay.position.x += 20
                topLeftPlay.position.x += 20
            }
        }
        if (touchTopLeft) {
            if (topLeftPlay.inBoundsLeft(currPosition: topLeftPlay.position.x)) {
                topLeftPlay.position.x -= 20
                topRightPlay.position.x -= 20
            }
        }

        if (touchBotRight) {
            if (botPlay.inBoundsRight(currPosition: botPlay.position.x)) {
                botPlay.position.x += 20
            }
        }

        if (touchBotLeft) {
            if (botPlay.inBoundsLeft(currPosition: botPlay.position.x)) {
                botPlay.position.x -= 20
            }
        }

        // Keep the top bar always moving left.

        
        let topRightMove1 = SKAction.moveBy(x: 210, y: 0, duration: 2)
        let topLeftMove1 = SKAction.moveBy(x: 50, y: 0, duration: 2)
        
        let topRightMove2 = SKAction.moveBy(x: 270, y: 0, duration: 2)
        let topLeftMove2 = SKAction.moveBy(x: 150, y: 0, duration: 2)
          

        let leftEnemySeq = SKAction.sequence([topLeftMove1, topLeftMove1.reversed()])
        let rightEnemySeq = SKAction.sequence([topRightMove1, topRightMove2])
        // Keep the top bar always moving right.

        //let totalSequence = SKAction.sequence([leftEnemySeq, rightEnemySeq])
        
        let doLeft = SKAction.repeatForever(leftEnemySeq)
        topLeftEnemy.run(doLeft, withKey: "moving")

        
        // Score on the bot goal. Opponent scores.
        if ((ball.position.y < botGoal.position.y + 20) && (ball.position.x > 100 && ball.position.x < 220)) {
            addScore(scoreLabel: oppScore)
        }
        
        // Score on the top goal. Player scores.
        if ((ball.position.y > topGoal.position.y - 20) && (ball.position.x > 100 && ball.position.x < 220)) {
            
        }
    }

    // Responder is signalled when fingers are lifted, and the touch input ends.
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first // as UITouch = (already knows).
        let touchLocation = touch?.location(in: self)

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

    // Deal with collisions between the ball and the goal.
    func didBegin(_ contact: SKPhysicsContact) {

        // Search and assign references for each of the goals.
        let topGoal = self.childNode(withName: "topGoal") as! Goal
        let botGoal = self.childNode(withName: "botGoal") as! Goal

        // Search and assign a refernce for the ball.
        let ball = self.childNode(withName: "ball") as! SKShapeNode

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
        self.physicsBody?.friction = 1
        self.physicsBody?.restitution = 0
        self.physicsBody?.isDynamic = false

        // For the time being every player is being made with uniform width and height.
        self.size = CGSize(width: 60, height: 15)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // Return if the player's position will keep them in bounds after a move.

    func inBoundsRight(currPosition: CGFloat) -> Bool {
        if (currPosition + 50 < (skView.frame.width)) {
            return true
        }
        return false
    }

    func inBoundsLeft(currPosition: CGFloat) -> Bool {
        if (currPosition > 50) {
            return true
        }
        return false
    }

}


class Goal: SKSpriteNode {

    /// Make a new SKSpriteNode goal with parameters for Foosball.
    init(image: String, xPosition: CGFloat, yPosition: CGFloat, title: String) {
        let texture = SKTexture(imageNamed: image)
        super.init(texture: texture, color: .blue, size: CGSize(width: 120, height: 10))
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

