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
    var bottomRightQuad = CGRect(x: skView.frame.width * 0.5, y: 0, width: skView.frame.width * 0.5, height: skView.frame.width * 0.25)
    var topLeftQuad = CGRect(x: 0, y: skView.frame.height * 0.25, width: skView.frame.width * 0.25, height: skView.frame.height * 0.25)
    var bottomLeftQuad = CGRect(x: 0, y: 0, width: skView.frame.width * 0.25, height: skView.frame.height * 0.25)
    
    // Use to play background music while playground is running.
    let backgroundMusicPlayer = AVAudioPlayer()
    
    // Variable to know when finger is continuously on screen.
    var fingerOnScreen = false

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
        let topLeftPlay = SKSpriteNode(color: .red, size: CGSize(width: 40, height: 10))
        topLeftPlay.name = "topLeftPlay"
        topLeftPlay.position = CGPoint(x: self.size.width * 0.25, y: self.size.height * 0.375)

        // Add the topLefPlay to the screen.
        self.addChild(topLeftPlay)

        // Deal with the physics of the top left player.
        topLeftPlay.physicsBody = SKPhysicsBody(rectangleOf: topLeftPlay.frame.size)
        topLeftPlay.physicsBody?.friction = 0.4
        topLeftPlay.physicsBody?.restitution = 0.1
        topLeftPlay.physicsBody?.isDynamic = false
        
        // Make the right player on the top bar.
        let topRightPlay = SKSpriteNode(color: .red, size: CGSize(width: 40, height: 10))
        topRightPlay.name = "topRightPlay"
        topRightPlay.position = CGPoint(x: self.size.width * 0.75, y: self.size.height * 0.375)
        
        // Add topRightPlay to the screen.
        self.addChild(topRightPlay)
        
        // Add the topRightPlay to the screen.
        topRightPlay.physicsBody = SKPhysicsBody(rectangleOf: topRightPlay.frame.size)
        topRightPlay.physicsBody?.friction = 0.4
        topRightPlay.physicsBody?.restitution = 0.1
        topRightPlay.physicsBody?.isDynamic = false
        
        // Make the bottom player.
        let botPlay = SKSpriteNode(color: .red, size: CGSize(width: 40, height: 10))
        botPlay.name = "botPlay"
        botPlay.position = CGPoint(x: self.size.width * 0.5, y: self.size.height * 0.125)
        
        // Deal with the physics of the bottom player.
        botPlay.physicsBody = SKPhysicsBody(rectangleOf: botPlay.frame.size)
        botPlay.physicsBody?.friction = 0.4
        botPlay.physicsBody?.restitution = 0.1
        botPlay.physicsBody?.isDynamic = false
        
        // Add the bottom player to the screen.
        self.addChild(botPlay)

        // Make the top goal.
        let goalTop = SKShapeNode(rectOf: CGSize(width: 120, height: 20))
        goalTop.position = CGPoint(x: self.size.width * 0.5, y: 0)
        goalTop.fillColor = SKColor.red

        // Make the bottom goal.
        let goalBot = SKShapeNode(rectOf: CGSize(width: 120, height: 20))
        goalBot.position = CGPoint(x: self.size.width * 0.5, y: 0)
        goalBot.fillColor = SKColor.red

        // Add both goals to the screen.
        self.addChild(goalTop)
        self.addChild(goalBot)
    }

    required init?(coder aDecorder: NSCoder) {
        super.init(coder: aDecorder)
    }
    
    // Checks if player is out of bounds and reset position to the max and minimum.
    func outBounds(player: SKSpriteNode) {
        if (player.position.x < 0) {
            player.position.x = 20
        }
            if(player.position.x > self.size.width ) {
                player.position.x = self.size.width - 20
            }
        }
    // Tells object that a touch has been inputted to the view.
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        fingerOnScreen = true
    }

    
    // Sends a signal to the gesture recognizers after touch has been identified.
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if (fingerOnScreen) {
            // The UITouch object holds all of the touch input like force, velocity, and duration.
            let touch = touches.first // as UITouch = (already knows).
            let touchLocation = touch?.location(in: self)
            
            // Search and assign for each of the player nodes.
            let topLeftPlay = self.childNode(withName: "topLeftPlay") as! SKSpriteNode
            let topRightPlay = self.childNode(withName: "topRightPlay") as! SKSpriteNode
            let botPlay = self.childNode(withName: "botPlay") as! SKSpriteNode
            
            if (topRightQuad.contains(touchLocation!)) {
                topRightPlay.position.x += 20
                topLeftPlay.position.x += 20
            }
            
            if (topLeftQuad.contains(touchLocation!)) {
                topLeftPlay.position.x -= 20
                topRightPlay.position.x -= 20
            }
            
            if (bottomRightQuad.contains(touchLocation!)) {
                botPlay.position.x += 20
            }
            
            if (bottomLeftQuad.contains(touchLocation!)) {
                botPlay.position.x -= 20
            }
            
            outBounds(player: topRightPlay)
            outBounds(player: topLeftPlay)
            outBounds(player: botPlay)
            
        }
    }
    
    
     // Responder is signalled when fingers are lifted, and the touch input ends.
     override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        fingerOnScreen = false
     }
}

//let gameScene = GameScene(size: CGSize(width: 320, height: 480))
let gameScene = GameScene(size: skView.bounds.size)
//gameScene.scaleMode = .aspectFill

// Done configuring the scene, time to present it to be interacted with.
skView.presentScene(gameScene)

// Present the view controller in the Live View window.
PlaygroundPage.current.liveView = skView

