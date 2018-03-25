//: A UIKit based Playground for presenting user interface

import UIKit
import PlaygroundSupport
import SpriteKit
import AVFoundation

// MARK: Control the view.
let skView = SKView(frame: CGRect(x: 0, y: 0, width: 480, height: 320))

// Quadrants of the screen for touch ID.
let topRightQuad = CGRect(x: self.size.width * 0.25, y: self.size.height * 0.5, width: self.size.width * 0.25, height: self.size.height * 0.5)
let bottomRightQuad = CGRect(x: self.size.width * 0.25, y: 0, width: self.size.width * 0.25, height: self.size.width * 0.5)
let topLeftQuad = CGRect(x: self.size.width * 0.25, y: self.size.height * 0.5, width: self.size.width * 0.25, height: self.size.height * 0.5)
let bottomLeftQuad = CGRect(x: 0, y: 0, width: self.size.width * 0.25, height: self.size.height * 0.5)


class GameScene: SKScene {
    
    // Use to play background music while playground is running.
    let backgroundMusicPlayer = AVAudioPlayer()

    override init(size: CGSize) {
        super.init(size: size)
        
        // Define sections of the screen for user input.
        let topRightQuad = SKShapeNode(rectOf: CGSize(width: self.size.width * 0.25, height: self.size.height * 0.5))
        topRightQuad.position = CGPoint(x: self.sizeWidth * 0.25, y: self.size.height * 0.5)

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

        // Make one of the bars that will hold the people.

        let character1 = SKSpriteNode(imageNamed: "FoosballTable")
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
        goalLeft.position = CGPoint(x: 0, y: self.size.height * 0.5)
        goalLeft.fillColor = SKColor.red

        // Make the right goal.
        let goalRight = SKShapeNode(rectOf: CGSize(width: 20, height: 120))
        goalRight.position = CGPoint(x: self.size.width, y: self.size.height * 0.5)
        goalRight.fillColor = SKColor.red

        // Add both goals to the screen.
        self.addChild(goalLeft)
        self.addChild(goalRight)
    }

    required init?(coder aDecorder: NSCoder) {
        super.init(coder: aDecorder)
    }
    
    func move(oldPosition: CGPoint, newPosition: CGPoint) {
       // let character1 = self.childNode(withName: playerCategoryName) as! SKSpriteNode
        
        let xDistance = fabs(oldPosition.x - newPosition.x)
        let yDistance = fabs(oldPosition.y - newPosition.y)
        let distance = sqrt(xDistance * xDistance + yDistance * yDistance)
        let sceneDiag = sqrt(self.frame.size.width * self.frame.size.width + self.frame.size.height * self.frame.size.height)
        print(distance)
        
        character1.run(SKAction.move(to: newPosition, duration: Double(distance / sceneDiag)))
    }
    
    // Tells object that a touch has been inputted to the view.
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        // The UITouch object holds all of the touch input like force, velocity, and duration.
        let touch = touches.first // as UITouch = (already knows).
        let touchLocation = touch?.location(in: self)
        
        if (topRightQuad.contains(touchLocation)) {
            print("In the top right quadrant.")
        }
        
        
        // Make sure that what touch is touching is actually the Foosball player.
        let body: SKPhysicsBody? = self.physicsWorld.body(at: touchLocation!)
        
    }
    
    // Sends a signal to the gesture recognizers after touch has been identified.
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        /* let character1 = self.childNode(withName: playerCategoryName) as! SKSpriteNode
        
        let touchLocation = touches.first!.location(in: self)
        if(character1.contains(touchLocation)) {
            move(oldPosition: character1.position, newPosition: touchLocation)
        }
        
        /*
        if fingerOnBar {
            
            let touch = touches.first
            let touchLocation = touches.first!.location(in: self.view)
            let prevTouchLoc = touch?.previousLocation(in: self)
            let character1 = self.childNode(withName: playerCategoryName) as! SKSpriteNode
            
            // Configure the player position.
            var newYPos = character1.position.y - (touchLocation.y - prevTouchLoc!.y)
            
            // Set constraints so that the bar doesn't go off the screen.
            newYPos = max(character1.size.height / 2, newYPos)
            newYPos = min(self.size.height - character1.size.height / 2, newYPos)
            
            character1.position = CGPoint(x: character1.position.x, y: newYPos)
        }
 */
    }
    
    
     // Responder is signalled when fingers are lifted, and the touch input ends.
     override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
     }
  */
    }
}

let gameScene = GameScene(size: skView.bounds.size)
gameScene.scaleMode = .aspectFill

// Done configuring the scene, time to present it to be interacted with.
skView.presentScene(gameScene)

// Present the view controller in the Live View window.
PlaygroundPage.current.liveView = skView

