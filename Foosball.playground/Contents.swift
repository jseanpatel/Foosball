//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport
import SpriteKit
import AVFoundation

// MARK: Control the view.

let skView = SKView(frame: CGRect(x:0, y:0, width: 480, height: 320))
let gameScene = GameScene(size: skView.bounds.size)
gameScene.scaleMode = .aspectFill

// Done configuring the scene, time to present it to be interacted with.
skView.presentScene(gameScene)

class GameScene: SKScene {
    
    // Use to play background music while playground is running.
    let backgroundMusicPlayer = AVAudioPlayer()
    
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
        ball.name = "shape"
        ball.position = CGPoint(x: self.size.width * 0.50, y: self.size.height * 0.5)
        ball.fillColor = SKColor.purple
        ball.lineWidth = 5
        ball.strokeColor = SKColor.orange
        
        // Add the ball to the screen.
        self.addChild(ball)
        
        // Deal with the physics of the ball.
        ball.physicsBody = SKPhysicsBody(circleOfRadius: ball.frame.size.width/2)
        ball.physicsBody?.restitution = 1
        ball.physicsBody?.linearDamping = 0
        ball.physicsBody?.allowsRotation = false
        
        // Get the ball moving.
        ball.physicsBody?.applyImpulse(CGVector(dx: 5, dy: -5))

        // Make one of the bars that will hold the people.
        let bar = SKShapeNode(rectOf: CGSize(width: 20, height: 120))
        bar.name = "bar"
        bar.position = CGPoint(x: self.size.width * 0.25, y: self.size.height * 0.25)
        bar.fillColor = SKColor.red
        
        // Add the bar to the screen.
        self.addChild(bar)
        
        // Deal with the physics of the bar.
        bar.physicsBody = SKPhysicsBody(rectangleOf: bar.frame.size)
        bar.physicsBody?.friction = 0.4
        bar.physicsBody?.restitution = 0.1
        bar.physicsBody?.isDynamic = false
    }
    
    required init?(coder aDecorder: NSCoder) {
        super.init(coder: aDecorder)
    }
}

// Present the view controller in the Live View window.
PlaygroundPage.current.liveView = skView
