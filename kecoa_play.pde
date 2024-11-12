import processing.sound.*;

class Cokroach {
  PVector pos;
  PVector vel;
  PImage img;
  float heading;
  boolean isDead = false;
  int bloodDisplayTime = 30;
  float bloodWidth = 90;
  float bloodHeight = 90;
  SoundFile squishSound; // Sound file for squish effect

  Cokroach(PImage _img, float _x, float _y, SoundFile _sound) {
    pos = new PVector(_x, _y);
    vel = PVector.random2D();
    heading = 0;
    img = _img;
    squishSound = _sound;
  }

  void live() {
    if (isDead) {
      bloodDisplayTime--;
      if (bloodDisplayTime > 0) {
        image(bloodImg, pos.x, pos.y, bloodWidth, bloodHeight);
      }
    } else {
      pos.add(vel);
      if (pos.x <= 0 || pos.x >= width) vel.x *= -1;
      if (pos.y <= 0 || pos.y >= height) vel.y *= -1;

      heading = atan2(vel.y, vel.x);
      pushMatrix();
      imageMode(CENTER);
      translate(pos.x, pos.y);
      rotate(heading + 0.5 * PI);
      image(img, 0, 0);
      popMatrix();
    }
  }

  boolean isClicked(float mx, float my) {
    float halfWidth = img.width / 2;
    float halfHeight = img.height / 2;
    return mx >= pos.x - halfWidth && mx <= pos.x + halfWidth &&
           my >= pos.y - halfHeight && my <= pos.y + halfHeight;
  }

  void die() {
    if (!isDead) {
      isDead = true;
      squishSound.play(); // Play sound effect when cockroach dies
    }
  }
}
