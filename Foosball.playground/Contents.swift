//: A UIKit based Playground for presenting user interface

import UIKit
import PlaygroundSupport
import SpriteKit
import AVFoundation

// MARK: Control the view.
let skView = SKView(frame: CGRect(x: 0, y: 0, width: 320, height: 480))

// Quadrants of the screen for touch ID.

class GameScene: SKScene {


    var topRightQuad = CGRect(x: skView.frame.width * 0.5, y: skView.frame.height * 0.25, width: skView.frame.width * 0.5, height: skView.frame.height * 0.25)
    var bottomRightQuad = CGRect(x: skView.frame.width * 0.5, y: 0, width: skView.frame.width * 0.5, height: skView.frame.height * 0.25)
    var topLeftQuad = CGRect(x: 0, y: skView.frame.height * 0.25, width: skView.frame.width * 0.5, height: skView.frame.height * 0.25)
    var bottomLeftQuad = CGRect(x: 0, y: 0, width: skView.frame.width * 0.5, height: skView.frame.height * 0.25)

    // Use to play background music while playground is running.
    let backgroundMusicPlayer = AVAudioPlayer()

    // Variables to know when finger is continuously on screen.
    var touchTopRight = false
    var touchTopLeft = false
    var touchBotLeft = false
    var touchBotRight = false

    override init(size: CGSize) {
        super.init(size: size)

        /**
        // Come back to configure the music here.
        let backgroundImage = SkSpriteNode(imageNamed "INSERTIMAGENAME")
        backgroundImage.position = CGPoint(self.frame.size.width / 2, self.frame.size.height / 2)
        self.add("INSERTIMAGENAME")
         */

        // Disable gravity across the board.
        self.physicsWorld.gravity = CGVector(dx: 0, dy: 0)

        // Add a table border so that the ball does not dissapear off the side. MAKE SURE TO COME BACK AND EDIT DISTANCES FROM THE EDGE OF THE SCREEN.
        let tableBorder = SKPhysicsBody(edgeLoopFrom: self.frame)

        // Make the new physics those of the created scene.
        self.physicsBody = tableBorder
        self.physicsBody?.friction = 0

        // Make a test ball.
        let ball = SKShapeNode(circleOfRadius: 10)

        ball.position = CGPoint(x: self.size.width * 0.50, y: self.size.height * 0.5)
        ball.fillColor = SKColor.purple
        ball.lineWidth = 5
        ball.strokeColor = SKColor.orange

        // Add the ball to the screen.
        self.addChild(ball)

        // Deal with the physics of the ball.
        ball.physicsBody = SKPhysicsBody(circleOfRadius: ball.frame.size.width / 2)
        ball.physicsBody?.restitution = 1
        ball.physicsBody?.linearDamping = 0
        ball.physicsBody?.allowsRotation = false

        // Get the ball moving.
        ball.physicsBody?.applyImpulse(CGVector(dx: 5, dy: -5))

        // Make the left player on the top bar.
        let topLeftPlay = Player(image: "noimageyet", name: "topLeftPlay", xPosition: self.size.width * 0.25, yPosition: self.size.height * 0.375)

        // Make the right player on the top bar.
        let topRightPlay = Player(image: "noimageyet", name: "topRightPlay", xPosition: self.size.width * 0.75, yPosition: self.size.height * 0.375)

        // Make the bottom player.
        let botPlay = Player(image: "noimageyet", name: "botPlay", xPosition: self.size.width * 0.5, yPosition: self.size.height * 0.125)

        // Add the players to the screen.
        self.addChild(topLeftPlay)
        self.addChild(topRightPlay)
        self.addChild(botPlay)

        // Make the top goal on the screen.
        let topGoal = Goal(image: "noimageyet", xPosition: self.size.width * 0.5, yPosition: self.size.height)

        // Make the bottom goal on the screen.
        let botGoal = Goal(image: "noimageyet", xPosition: self.size.width * 0.5, yPosition: 0)

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

        // Search and assign for each of the player nodes.
        let topLeftPlay = self.childNode(withName: "topLeftPlay") as! SKSpriteNode
        let topRightPlay = self.childNode(withName: "topRightPlay") as! SKSpriteNode
        let botPlay = self.childNode(withName: "botPlay") as! SKSpriteNode

        if (touchTopRight) {
            //if (topRightPlay.outBounds(currPosition: topRightPlay.position.x)) {
                topRightPlay.position.x += 20
                topLeftPlay.position.x += 20
                //  }
            }
            if (touchTopLeft) {
                topLeftPlay.position.x -= 20
                topRightPlay.position.x -= 20
            }

            if (touchBotRight) {
                botPlay.position.x += 20
            }

            if (touchBotLeft) {
                botPlay.position.x -= 20
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
            self.physicsBody?.friction = 0.4
            self.physicsBody?.restitution = 0.1
            self.physicsBody?.isDynamic = false

            // For the time being every player is being made with uniform width and height.
            self.size = CGSize(width: 60, height: 15)
        }

        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

        
    func outBounds(currPosition: Int) -> Bool {
        if ((currPosition + 20 < Int(skView.frame.width) ) && (currPosition - 20 > 0)) {
            return true
        }
        return false
    }

    }

    class Goal: SKSpriteNode {

        /// Make a new SKSpriteNode goal with parameters for Foosball.
        init(image: String, xPosition: CGFloat, yPosition: CGFloat) {
            let texture = SKTexture(imageNamed: image)
            super.init(texture: texture, color: .blue, size: CGSize(width: 120, height: 10))
            self.position = CGPoint(x: xPosition, y: yPosition)
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

