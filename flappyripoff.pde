PImage bg, mohawk, welcomescreen;
PImage wallpic;
PFont kellyslab;
boolean gameActive;
int score, highscore;
int x;
int bird_y, vertical;
int startTime, startFrame;
ArrayList<Walls> levels = new ArrayList<Walls>();
void setup()
{
  //media
  bg = loadImage("bg.png"); //background image: 2500 x 1200
  mohawk = loadImage("mo.png"); //bird image: 250 x 250
  welcomescreen = loadImage("welcomescreen.png"); //welcome: 800 x 1200
  wallpic =loadImage("wall.png");
  kellyslab = createFont("KellySlab-Regular.ttf", 28);
  //initialize
  gameActive = false;
  score = 0; 
  highscore = 0;
  vertical = 0;
  x = 0;
  
  size(400, 600);
  frameRate(60);
  setStyle();
}
void draw()
{
  if (gameActive)
  {
    bgscroll();
    //wall
    generateWall();
    //bird is falling lower by 1 every frame
    vertical += 1;  
    bird_y += vertical; 
    imageMode(CENTER);
    image(mohawk, width/2, bird_y, 70, 70);
    //score
    score = (millis()-startTime)/800;
    setStyle();
    text("Score: "+score, 25, height-20);
  }
  else {
    imageMode(CENTER);
    image(welcomescreen, width/2, height/2, 400, 600);
    setStyle();
    text("Score: "+score, 30, 500);
    highscore = max(highscore, score);
    text("High Score: "+highscore, 30, 530);
  }
}
void keyPressed(){
  if (key==' '){
    vertical = -15;   //bird flies up by 15 with every tap
  }
}
void mouseClicked(){
  if(!gameActive) {
    //if game on starting screen, reset wall and score, start game
    score = 0;
    x = 0;
    bird_y = height/2;
    levels.clear();
    gameActive = true;
    startTime = millis();
    startFrame = frameCount;
  }
}
void bgscroll(){
  //background generation
  imageMode(CORNER);
  image(bg, x-bg.width, 0);
  image(bg, x, 0);
  x += 5; //speed of background scrolling
  //loop background around
  if(x == 1250){
    x = 0; 
  }
}
void generateWall(){
  if ((frameCount-startFrame)%50==0){
    levels.add(new Walls());
  }
  int i = 0;
  while (i<levels.size()){
    if (levels.get(i).collide() || bird_y>height+30 || bird_y<0-30){ //levels.get(i).in_range() && 
      gameActive = false;
      return;
    }
    if(levels.get(i).update()){
      levels.get(i).display();
      i++;
    }
    else{
      levels.remove(i);
    }
  }
}
void setStyle(){
  fill(#242626);
  textFont(kellyslab);
}
