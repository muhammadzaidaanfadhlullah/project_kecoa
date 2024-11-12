ArrayList<Cokroach> coks;
PImage img, bloodImg;
SoundFile squishSound;
int deadcount = 0;
int spawnInterval = 5000;
int lastSpawnTime = 0;

void setup() {
  size(800, 800);
  coks = new ArrayList<Cokroach>();
  img = loadImage("kecoa.png");
  bloodImg = loadImage("darah1.png");
  squishSound = new SoundFile(this, "death.mp3"); // Load squish sound effect
}

void draw() {
  background(255);

  if (millis() - lastSpawnTime > spawnInterval) {
    coks.add(new Cokroach(img, random(width), random(height), squishSound));
    lastSpawnTime = millis();
  }

  for (int i = coks.size() - 1; i >= 0; i--) {
    Cokroach c = coks.get(i);
    if (c.isDead && c.bloodDisplayTime <= 0) {
      coks.remove(i);
    } else {
      c.live();
    }
  }

  fill(51);
  textSize(16);
  text("Kecoa yang muncul: " + coks.size(), 50, 750);
  text("Skor: " + deadcount, 700, 750);
}

void mouseClicked() {
  if (mouseButton == LEFT) {
    for (int i = coks.size() - 1; i >= 0; i--) {
      Cokroach c = coks.get(i);
      if (c.isClicked(mouseX, mouseY)) {
        c.die(); // Call die method to mark as dead and play sound
        deadcount += 5;
        break;
      }
    }
  }
}
