class Walls
{
  int x;
  int wall_width = 50;
  int gap = 100;
  int top_height, bottom_height;
  public Walls(){
    int mid = int(random(-3, 3))*25 + height/2;
    x = 0-wall_width;
    top_height = mid-gap;
    bottom_height = mid+gap;
    
  }
  boolean update(){
    x = x+6;
    if (x>=width){
      return false;
    }
    return true;
  }
  void display(){
    fill(131, 102, 217);
    noStroke();
    rectMode(CORNER);
    image(wallpic, x, top_height-wallpic.height);//, wall_width, top_height);
    image(wallpic, x, bottom_height); //, wall_width, bottom_height);
  }
  boolean collide(){
    int x1 = x;
    int x2 = x+wall_width;
    int y2 = top_height+30;
    int y3 = bottom_height-30;
    int bx = width/2;
    int by = bird_y;
    if ((bx>=x1 && bx<=x2) && (by<=y2 || by>=y3)){
      return true;
    }
    return false;
  }
  //boolean in_range(){
  //  int nx = x + wall_width/2;
  //  boolean temp = nx>width/2-30 && nx<width/2+30;
  //  return temp;
  //}
}
