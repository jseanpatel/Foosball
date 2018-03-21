//: A UIKit based Playground for presenting user interface
<<<<<<< HEAD

=======
  
>>>>>>> f2fc1f73616e8f391ce13852d7baadfb8d4cf967
import UIKit
import PlaygroundSupport
import SpriteKit
import AVFoundation

// MARK: Control the view.

<<<<<<< HEAD
let skView = SKView(frame: CGRect(x: 0, y: 0, width: 480, height: 320))
=======
let skView = SKView(frame: CGRect(x:0, y:0, width: 480, height: 320))
>>>>>>> f2fc1f73616e8f391ce13852d7baadfb8d4cf967
let gameScene = GameScene(size: skView.bounds.size)
gameScene.scaleMode = .aspectFill

// Done configuring the scene, time to present it to be interacted with.
skView.presentScene(gameScene)

<<<<<<< HEAD

var fingerOnBar = false


class GameScene: SKScene {
    
    
    // Categories for matching up user touch with appropriate object that is being touched.
    let ballCategoryName = "ball"
    let goalCategoryName = "goal"
    let playerCategoryName = "player"

    // Use to play background music while playground is running.
    let backgroundMusicPlayer = AVAudioPlayer()

    override init(size: CGSize) {
        super.init(size: size)

=======
class GameScene: SKScene {
    
    // Use to play background music while playground is running.
    let backgroundMusicPlayer = AVAudioPlayer()
    
    override init(size: CGSize) {
        super.init(size: size)
        
>>>>>>> f2fc1f73616e8f391ce13852d7baadfb8d4cf967
        /**
        // Come back to configure the music here.
        let backgroundImage = SkSpriteNode(imageNamed "INSERTIMAGENAME")
        backgroundImage.position = CGPoint(self.frame.size.width / 2, self.frame.size.height / 2)
        self.add("INSERTIMAGENAME")
         */
<<<<<<< HEAD

        // Disable gravity across the board.
        self.physicsWorld.gravity = CGVector(dx: 0, dy: 0)

        // Add a table border so that the ball does not dissapear off the side. MAKE SURE TO COME BACK AND EDIT DISTANCES FROM THE EDGE OF THE SCREEN.
        let tableBorder = SKPhysicsBody(edgeLoopFrom: self.frame)

        // Make the new physics those of the created scene.
        self.physicsBody = tableBorder
        self.physicsBody?.friction = 0

        // Make a test ball.
        let ball = SKShapeNode(circleOfRadius: 10)
        ball.name = ballCategoryName
=======
        
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
>>>>>>> f2fc1f73616e8f391ce13852d7baadfb8d4cf967
        ball.position = CGPoint(x: self.size.width * 0.50, y: self.size.height * 0.5)
        ball.fillColor = SKColor.purple
        ball.lineWidth = 5
        ball.strokeColor = SKColor.orange
<<<<<<< HEAD

        // Add the ball to the screen.
        self.addChild(ball)

        // Deal with the physics of the ball.
        ball.physicsBody = SKPhysicsBody(circleOfRadius: ball.frame.size.width / 2)
        ball.physicsBody?.restitution = 1
        ball.physicsBody?.linearDamping = 0
        ball.physicsBody?.allowsRotation = false

=======
        
        // Add the ball to the screen.
        self.addChild(ball)
        
        // Deal with the physics of the ball.
        ball.physicsBody = SKPhysicsBody(circleOfRadius: ball.frame.size.width/2)
        ball.physicsBody?.restitution = 1
        ball.physicsBody?.linearDamping = 0
        ball.physicsBody?.allowsRotation = false
        
>>>>>>> f2fc1f73616e8f391ce13852d7baadfb8d4cf967
        // Get the ball moving.
        ball.physicsBody?.applyImpulse(CGVector(dx: 5, dy: -5))

        // Make one of the bars that will hold the people.
<<<<<<< HEAD
        let character1 = SKSpriteNode(imageNamed: "FoosballTable")
        character1.name = playerCategoryName
        character1.position = CGPoint(x: self.size.width * 0.25, y: self.size.height * 0.25)

        // Add the bar to the screen.
        self.addChild(character1)

        // Deal with the physics of the bar.
        character1.physicsBody = SKPhysicsBody(rectangleOf: character1.frame.size)
        character1.physicsBody?.friction = 0.4
        character1.physicsBody?.restitution = 0.1
        character1.physicsBody?.isDynamic = false

        // Make the left goal.
        let goalLeft = SKShapeNode(rectOf: CGSize(width: 20, height: 120))
        goalLeft.name = goalCategoryName
        goalLeft.position = CGPoint(x: 0, y: self.size.height * 0.5)
        goalLeft.fillColor = SKColor.red

        // Make the right goal.
        let goalRight = SKShapeNode(rectOf: CGSize(width: 20, height: 120))
        goalRight.name = goalCategoryName
        goalRight.position = CGPoint(x: self.size.width, y: self.size.height * 0.5)
        goalRight.fillColor = SKColor.red

        // Add both goals to the screen.
        self.addChild(goalLeft)
        self.addChild(goalRight)



    }

    required init?(coder aDecorder: NSCoder) {
        super.init(coder: aDecorder)
    }

    // Tells object that a touch has been inputted to the view.
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        // The UITouch object holds all of the touch input like force, velocity, and duration.
        let touch = touches.first // as UITouch = (already knows).
        let touchLocation = touch?.location(in: self)

        // Make sure that what touch is touching is actually the Foosball player.
        let body: SKPhysicsBody? = self.physicsWorld.body(at: touchLocation!)
        print(body?.node?.name)


        if body?.node?.name == playerCategoryName {
            print("The bar is being moved.")
            fingerOnBar = true
        }
    }

    // Sends a signal to the gesture recognizers after touch has been identified.
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if fingerOnBar {
            let touch = touches.first
            let touchLocation = touches.first!.location(in: self.view)
            let prevTouchLoc = touch?.previousLocation(in: self)

            let character1 = self.childNode(withName: playerCategoryName) as! SKSpriteNode

            // Change the touched position, newYPos because character will only be moved up a down.
            
            // Configure the player position.

            var newYPos = character1.position.y + (touchLocation.y - (prevTouchLoc?.y)!)
            newYPos = max(character1.size.height / 2, newYPos)
            newYPos = min(self.size.width - character1.size.width / 2, newYPos)
            
            character1.position = CGPoint(x: character1.position.x, y: newYPos)
        

        }
    }
/**
    // Responder is signalled when fingers are lifted, and the touch input ends.
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        <#code#>
    }
*/
=======
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
>>>>>>> f2fc1f73616e8f391ce13852d7baadfb8d4cf967
}

// Present the view controller in the Live View window.
PlaygroundPage.current.liveView = skView
